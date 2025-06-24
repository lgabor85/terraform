# ───────────────────────────────────────────┐
# Nested modules for Azure NetApp Files (ANF)|
# ───────────────────────────────────────────┘
# This module creates a backup policy for ANF volumes as a workaround for the current limitations in the AzureRM provider.
# see: https://github.com/hashicorp/terraform-provider-azurerm/issues/29901
module "backup_policy" {
  source    = "../backup_policy"
  parent_id = var.account_id
  location  = var.location
  properties = {
    enabled              = true
    dailyBackupsToKeep   = var.anf_backup_daily
    weeklyBackupsToKeep  = var.anf_backup_weekly
    monthlyBackupsToKeep = var.anf_backup_monthly
  }
}

# Create the destination volume in the specified zone with replication settings
# Create NetApp Volume
resource "azurerm_netapp_volume" "source" {
  name                = var.source_volume_name
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  pool_name           = var.pool_name
  location            = var.location
  volume_path         = var.volume_path
  protocols           = ["NFSv4.1"]
  service_level       = "Standard"
  subnet_id           = var.subnet_id
  zone                = var.source_zone
  storage_quota_in_gb = var.storage_quota_in_gb
  lifecycle {
    ignore_changes = all
    # prevent_destroy = true 
  }
  export_policy_rule {
    rule_index        = 1
    allowed_clients   = ["0.0.0.0/0"]
    protocols_enabled = ["NFSv4.1"]
    unix_read_only    = false
    unix_read_write   = true
  }
    # Enabling backup policy
  data_protection_backup_policy {
    backup_vault_id  = var.backup_vault_id
    backup_policy_id = module.backup_policy.policy_id
    policy_enabled   = true
  }
}


resource "azapi_resource" "dest" {
  type      = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes@2025-01-01"  
  name      = var.destination_volume_name  # use same path as source for consistency
  parent_id = var.capacity_pool_id  # parent is the capacity pool (from AzureRM)
  location  = var.location              # same region as source

  body = {
    properties = {
      volumeType = "DataProtection"           # designate as a DataProtection volume (replica)
      creationToken       = var.volume_path,       # use same mount path as source for consistency
      serviceLevel        = var.service_level,
      usageThreshold      = var.dest_quota_gb, # bytes (e.g. 100 GiB -> 107374182400)
      subnetId            = var.subnet_id,
      protocolTypes       = var.protocols         # e.g. ["NFSv4.1"] or ["CIFS"], match source protocols

      exportPolicy = {
        rules = [
          {
            ruleIndex        = 1
            allowedClients   = "0.0.0.0/0"
            unixReadOnly    = false
            unixReadWrite   = true
            nfsv3            = false
            nfsv41            = true
            kerberos5ReadOnly = false
            kerberos5ReadWrite = false
          }
        ]
      }

      dataProtection = {
        replication = {
          endpointType          = "dst"                     
          remoteVolumeResourceId = azurerm_netapp_volume.source.id  
          remoteVolumeRegion     = var.location             
          replicationSchedule    = var.replication_schedule                
        }
      }
    }
    zones = [var.dest_zone]  # specify destination zone for the volume
  }

  schema_validation_enabled = false   # disable schema checks if AzAPI provider schema is behind the latest API
  ignore_missing_property   = true    # ignore extra properties from Azure (e.g. auto-generated replicationId)
}

# This null_resource uses a local-exec provisioner to run the Azure CLI command
resource "null_resource" "authorize_replication" {
  # Use triggers or depends_on to ensure this runs after volumes are created
  triggers = {
    src_id = azurerm_netapp_volume.source.id
    dst_id = azapi_resource.dest.id
  }

  provisioner "local-exec" {
    command = <<EOT
      az netappfiles volume replication approve \
        --resource-group ${azurerm_netapp_volume.source.resource_group_name} \
        --account-name  ${azurerm_netapp_volume.source.account_name} \
        --pool-name     ${azurerm_netapp_volume.source.pool_name} \
        --name          ${azurerm_netapp_volume.source.name} \
        --remote-volume-resource-id ${azapi_resource.dest.id}
    EOT
  }
}
