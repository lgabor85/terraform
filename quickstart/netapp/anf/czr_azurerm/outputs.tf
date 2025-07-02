output "resource_group_name" {
  value       = azurerm_resource_group.example.name
  description = "value of the resource group name"
}

output "netapp_account_name" {
  value       = azurerm_netapp_account.example_primary.name
  description = "value of the NetApp account name"
}

output "netapp_pool_name" {
  value       = azurerm_netapp_pool.example_primary.name
  description = "value of the NetApp pool name"
}

output "netapp_volume_name" {
  value       = azurerm_netapp_volume.example_primary.name
  description = "value of the NetApp volume name"
}