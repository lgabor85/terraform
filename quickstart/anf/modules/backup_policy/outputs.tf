output "policy_id" {
  value       = azapi_resource.anf_daily_only_backup_policy.id
  description = "The resource ID of the created NetApp backup policy."
}