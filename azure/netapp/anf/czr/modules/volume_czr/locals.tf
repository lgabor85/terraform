# This local block checks if the primary volume exists. 
locals {
  create_primary = can(data.azurerm_netapp_volume.existing.id) ? 0 : 1
}