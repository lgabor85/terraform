output "resource_group_name" {
  value = azurerm_resource_group.anf-rg.name
}

output "netapp_account_name" {
  value = azurerm_netapp_account.anf-account.name
}

output "netapp_pool_name" {
  value = azurerm_netapp_pool.anf-pool.name
}

output "netapp_volume_name" {
  value = azurerm_netapp_volume.anf-volume.name
}