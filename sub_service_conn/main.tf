# create subscription based on billing account data
resource "azurerm_subscription" "subscription" {
  subscription_name = format("TOPdeskSAAS-%s-%s", upper(var.site_stage_code), upper(var.site_name))
  billing_scope_id  = data.azurerm_billing_mca_account_scope.mca_account_scope.id
  workload          = var.workload
}

# create azure ad application
resource "azuread_application" "site_azuread_application" {
  display_name = format("TOPdeskSAAS-%s-%s", upper(var.site_stage_code), upper(var.site_name))
  owners       = [data.azuread_client_config.current.object_id]
}

# create service principal for azure ad application
resource "azuread_service_principal" "site_azuread_service_principal" {
  application_id               = azuread_application.site_azuread_application.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  feature_tags {
    enterprise = true
  }
}

# create password for service principal
resource "azuread_service_principal_password" "password" {
  service_principal_id = azuread_service_principal.site_azuread_service_principal.object_id
}

# create random uuid for role_definition_id at azurerm_role_definition below
resource "random_uuid" "role_definition_id" {
}

# create custom role to allow service principal to assign roles, see explanation below at azurerm_role_assignment.allow_role_assignment
# this role has to be created per site, since we cannot create global custom roles with our current Azure AD tier
resource "azurerm_role_definition" "role_defition_role_assignment_contributor" {
  role_definition_id = random_uuid.role_definition_id.result
  name               = format("Allow Role Assignment %s %s", var.site_stage_code, var.site_name)
  scope              = format("/subscriptions/%s", azurerm_subscription.subscription.subscription_id)
  description        = "Custom role for the Azure Devops pipelines: allows the service principal for the service connection to set assign required permissions for VNET peering"

  permissions {
    actions = [
      "Microsoft.Authorization/roleAssignments/write",
      "Microsoft.Authorization/roleAssignments/delete",
    ]
    not_actions = []
  }
}

# give service connection service principal custom "Allow Role Assignment" role defined above,
# with this role it can assign the Network Contributor role to the service principal of the hub site (to which the new site peers to) in the network module to set up vnet peering
resource "azurerm_role_assignment" "allow_role_assignment" {
  scope              = format("/subscriptions/%s", azurerm_subscription.subscription.subscription_id)
  role_definition_id = azurerm_role_definition.role_defition_role_assignment_contributor.role_definition_resource_id
  principal_id       = azuread_service_principal.site_azuread_service_principal.id
}

# give service connection service principal Contributor role
resource "azurerm_role_assignment" "contributor" {
  scope                = format("/subscriptions/%s", azurerm_subscription.subscription.subscription_id)
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.site_azuread_service_principal.id
}

# give service connection service principal User Access Administrator role
resource "azurerm_role_assignment" "user_access_administrator" {
  scope                = format("/subscriptions/%s", azurerm_subscription.subscription.subscription_id)
  role_definition_name = "User Access Administrator"
  principal_id         = azuread_service_principal.site_azuread_service_principal.id
}

# TODO: not sure if something like this is still needed for WAN connection which replaces vnet peering module
# give service connection service principal Network Contributor role on the vnet at the hub site that the new site will vnet-peer with
resource "azurerm_role_assignment" "hub_vnet" {
  scope                = var.hub_vnet_role_assignment_scope # tfvars for test/acc/prod
  role_definition_name = "Network Contributor"
  principal_id         = azuread_service_principal.site_azuread_service_principal.id
}

# create Azure Devops service connection based on the created subscription, the Azure Devops project data and the created service principal
# we have to use the "manual" option for azuredevops_serviceendpoint_azurerm here, because of the specific role requirements of the linked service principal which are set above (you cannot set these roles programmatically with the automatic option)
resource "azuredevops_serviceendpoint_azurerm" "service_connection" {
  project_id            = data.azuredevops_project.saasops_project.id
  service_endpoint_name = azurerm_subscription.subscription.subscription_name
  description           = "Managed from the initialization pipeline with Terraform"
  credentials {
    serviceprincipalid  = azuread_service_principal.site_azuread_service_principal.application_id
    serviceprincipalkey = azuread_service_principal_password.password.value
  }
  azurerm_spn_tenantid      = data.azuread_client_config.current.tenant_id # tst/acc or prod specific
  azurerm_subscription_id   = azurerm_subscription.subscription.subscription_id
  azurerm_subscription_name = azurerm_subscription.subscription.subscription_name
}
