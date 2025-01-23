resource "azuredevops_serviceendpoint_azurerm" "example" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "4262-service-connection"
  description           = "Demo Azure Resource Manager service connection"
  credentials {
    serviceprincipalid  = "$ARM_CLIENT_ID"
    serviceprincipalkey = "$ARM_CLIENT_SECRET"
  }

  azurerm_spn_tenantid      = "$ARM_TENANT_ID"
  azurerm_subscription_id   = "$ARM_SUBSCRIPTION_ID"
  azurerm_subscription_name = "$ARM_SUB_NAME"
}

resource "azuredevops_project" "project" {
  name       = "topdemo"
  visibility = "private"
}