output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.rg.location
}

output "user_assigned_identity_id" {
  description = "The ID of the user-assigned managed identity"
  value       = azurerm_user_assigned_identity.mi.id
}

output "user_assigned_identity_client_id" {
  description = "The client ID of the user-assigned managed identity"
  value       = azurerm_user_assigned_identity.mi.client_id
}

output "user_assigned_identity_principal_id" {
  description = "The principal ID of the user-assigned managed identity"
  value       = azurerm_user_assigned_identity.mi.principal_id
}

output "role_assignment_id" {
  description = "The ID of the role assignment"
  value       = azurerm_role_assignment.login.id
}

output "subscription_id" {
  description = "The ID of the subscription"
  value       = data.azurerm_client_config.current.subscription_id
}