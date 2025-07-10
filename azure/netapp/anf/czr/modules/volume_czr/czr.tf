# check if primary volume exists
# this is used to prevent the module from failing if the primary volume does not exist

data "azurerm_netapp_volume" "existing" {
  name                = var.primary_volume_name
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  pool_name           = var.pool_name
  # if the volume is missing, this will error at plan-time
}

# netapp source volume
resource "azurerm_netapp_volume" "container_netapp_volume" {
  count = local.create_primary

  lifecycle {
    prevent_destroy = false
  }

  name                       = var.primary_volume_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  account_name               = var.account_name
  pool_name                  = var.pool_name
  volume_path                = var.volume_path
  service_level              = var.service_level
  subnet_id                  = var.subnet_id
  network_features           = var.network_features
  protocols                  = var.protocols
  security_style             = var.security_style
  storage_quota_in_gb        = var.storage_quota_in_gb
  snapshot_directory_visible = false
  zone                       = var.source_zone
  tags                       = var.container_netapp_volume_tags

  data_protection_snapshot_policy {
    snapshot_policy_id = var.snapshot_policy_id
  }

  data_protection_backup_policy {
    backup_vault_id  = var.backup_vault_id
    backup_policy_id = var.backup_policy_id
    policy_enabled   = true
  }

}

# netapp destination volume
resource "azurerm_netapp_volume" "container_netapp_volume_secondary" {
  lifecycle {
    prevent_destroy = false
  }

  count      = local.create_primary
  depends_on = [azurerm_netapp_volume.container_netapp_volume]

  name                = var.secondary_volume_name
  location            = var.location
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  pool_name           = var.pool_name
  volume_path         = var.volume_path
  service_level       = var.service_level
  subnet_id           = var.subnet_id
  network_features    = var.network_features
  protocols           = var.protocols
  security_style      = var.security_style
  storage_quota_in_gb = var.storage_quota_in_gb
  zone                = var.dest_zone
  tags                = var.container_netapp_volume_tags

  data_protection_replication {
    endpoint_type          = "dst"
    remote_volume_location = var.location

    remote_volume_resource_id = local.create_primary == 1 ? azurerm_netapp_volume.container_netapp_volume[0].id : data.azurerm_netapp_volume.existing.id

    replication_frequency = var.replication_schedule
  }

}
