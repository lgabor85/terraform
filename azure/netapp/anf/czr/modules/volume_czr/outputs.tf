output "container_netapp_volume_id" {
  description = "ID of the source NetApp volume"
  value = (can(azurerm_netapp_volume.container_netapp_volume[0].id) ?
    azurerm_netapp_volume.container_netapp_volume[0].id :
  data.azurerm_netapp_volume.existing.id)
}

output "container_netapp_volume_name" {
  description = "Name of the source NetApp volume"
  value = (can(azurerm_netapp_volume.container_netapp_volume[0].name) ?
    azurerm_netapp_volume.container_netapp_volume[0].name :
  data.azurerm_netapp_volume.existing.name)
}