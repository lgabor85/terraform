resource "azuredevops_serviceendpoint_azurerm" "example" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "4262-service-connection"
  description           = "Demo Azure Resource Manager service connection"
  credentials {
    serviceprincipalid  = "$Env:ARM_CLIENT_ID"
    serviceprincipalkey = "$Env:ARM_CLIENT_SECRET"
  }

  azurerm_spn_tenantid      = "$Env:ARM_TENANT_ID"
  azurerm_subscription_id   = "$Env:ARM_SUBSCRIPTION_ID"
  azurerm_subscription_name = "$Env:ARM_SUB_NAME"
}

resource "azuredevops_project" "project" {
  name       = "example-project"
  visibility = "private"
}