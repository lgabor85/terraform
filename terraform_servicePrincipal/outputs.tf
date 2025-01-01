output "service_principal_app_id" {
  description = "The application ID of the service principal"
  value       = azuread_application.authApp.client_id
}

output "service_principal_password" {
    description = "The password of the service principal"
    value       = azuread_application_password.spwd.value
    sensitive   = true
}

output "subscription_id" {
  description = "The ID of the subscription"
  value       = data.azurerm_client_config.current.subscription_id
}