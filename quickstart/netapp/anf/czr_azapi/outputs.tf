output "resource_group_name" {
  value = azurerm_resource_group.anf-rg.name
}

output "netapp_account_name" {
  value = azurerm_netapp_account.anf-account.name
}

output "netapp_pool_name" {
  value = azurerm_netapp_pool.anf-pool.name
}

output "replica_volume_id" {
  description = "Resource ID of the created destination (replica) volume"
  value       = module.anf_czr.destination_volume_id
}