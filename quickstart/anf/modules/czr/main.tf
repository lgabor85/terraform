# Create the destination volume in the specified zone with replication settings
resource "azapi_resource" "anf_dest_volume" {
  type      = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes@2025-01-01"
  name      = var.volume_path      # Volume name (must be unique in the NetApp account)
  parent_id = var.capacity_pool_id # Parent capacity pool resource
  location  = var.location

  body = {
    properties = {
      creationToken  = var.volume_path # The file path (mount target name) for the volume
      serviceLevel   = var.service_level
      usageThreshold = var.usage_threshold # Quota in GiB
      subnetId       = var.subnet_id
      volumeType     = "DataProtection" # Mark as DataProtection volume (required for replication destination)
      dataProtection = {
        replication = {
          endpointType           = "dst"                    # This volume is the replication destination
          remoteVolumeResourceId = var.source_volume_id     # Source volume to replicate from
          remoteVolumeRegion     = var.location             # Region of the source volume (same region for CZR)
          replicationSchedule    = var.replication_schedule # e.g., "hourly", "daily", "_10minutely"
        }
      }
      # Optionally, include protocol types and other settings to match the source volume.
      # protocolTypes = ["NFSv3"]  # Example: ensure this matches source volume's protocol (NFS/SMB) for compatibility
    }
    zones = [var.destination_zone] # Place volume in the specified AZ (different from source's AZ)
  }

  # (Optional) Prevent accidental deletion of the destination volume.
  # lifecycle {
  #   prevent_destroy = true  # Enable to prevent destroying the volume without manual override:contentReference[oaicite:6]{index=6}
  # }
}

# Authorize replication on the source volume by updating its dataProtection settings
resource "azapi_update_resource" "anf_source_replication" {
  type        = "Microsoft.NetApp/netAppAccounts/capacityPools/volumes@2025-01-01"
  resource_id = var.source_volume_id
  # Ensure the source update runs after the destination volume is created:
  depends_on = [azapi_resource.anf_dest_volume]

  body = {
    properties = {
      dataProtection = {
        replication = {
          endpointType           = "src"                             # Mark the source volume as the replication source
          remoteVolumeResourceId = azapi_resource.anf_dest_volume.id # Reference to the destination volume
          remoteVolumeRegion     = var.location
          replicationSchedule    = var.replication_schedule
        }
      }
    }
  }
}
