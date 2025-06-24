output "netapp_volume_name" {
  value = azurerm_netapp_volume.source.name
}

output "destination_volume_id" {
  description = "Resource ID of the created destination (replica) volume"
  value       = azapi_resource.dest.id
}

output "replication_status" {
  description = "Replication state of the destination volume (mirror status)"
  value       = azapi_resource.dest.output.dest_properties.dataProtection.replication.mirrorState
  # The mirrorState can be 'Uninitialized', 'Mirrored', or 'Broken', etc., indicating replication health:contentReference[oaicite:9]{index=9}.
}

# (Optional) Output relationship status if needed (e.g., idle, transferring):
# output "replication_relationship_status" {
#   value = jsondecode(azapi_resource.anf_dest_volume.output).properties.dataProtection.replication.relationshipStatus
# }
