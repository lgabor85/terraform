output "policy_id" {
  value       = azapi_resource.backup_policy.id
  description = "The resource ID of the created NetApp backup policy."
}