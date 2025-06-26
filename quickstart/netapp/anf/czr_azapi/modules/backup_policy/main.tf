resource "azapi_resource" "anf_daily_only_backup_policy" {
  type      = "Microsoft.NetApp/netAppAccounts/backupPolicies@2024-09-01"
  parent_id = var.parent_id
  name      = var.policy_name
  location  = var.location

  body = {
    properties = {
      enabled              = var.properties.enabled
      dailyBackupsToKeep   = var.properties.dailyBackupsToKeep
      weeklyBackupsToKeep  = var.properties.weeklyBackupsToKeep
      monthlyBackupsToKeep = var.properties.monthlyBackupsToKeep
    }
  }
}
