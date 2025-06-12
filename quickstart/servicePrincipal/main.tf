# Retrieve the current subscription details
data "azurerm_client_config" "current" {}

# Create an Azure AD application
resource "azuread_application" "authApp" {
    display_name = "auth-app-${var.resource_suffix}"
    owners = [ data.azurerm_client_config.current.object_id ]
}

# Create a service principal for the Azure AD application
resource "azuread_service_principal" "authSp" {
    client_id = azuread_application.authApp.client_id
    owners = [ data.azurerm_client_config.current.object_id ]
}

# Create a service principal password with automatic generation
resource "azuread_application_password" "spwd" {
    application_id = azuread_application.authApp.id
    end_date       = "2099-01-01T00:00:00Z"
}

# Assign the Contributor role to the service principal at the subscription scope
resource "azurerm_role_assignment" "sp_contributor" {
    scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
    role_definition_name = "Contributor"
    principal_id         = azuread_service_principal.authSp.object_id
}
