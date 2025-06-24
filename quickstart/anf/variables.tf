variable "resource_group_location" {
  type        = string
  default     = "westeurope"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "prevent_volume_destruction" {
  type        = bool
  default     = false
  description = "Should an `azurerm_netapp_volume` be protected against deletion (intentionally or unintentionally)? Defaults to `true`."
}

variable "anf-snapshots_to_keep" {
  type        = number
  default     = 10
  description = "Number of snapshots to keep for the NetApp volume."
}

variable "anf_snapshot_hour" {
  type        = number
  default     = 00
  description = "Hour of the day to take snapshots for the NetApp volume."
}

variable "anf_snapshot_minute" {
  type        = number
  default     = 00
  description = "Minute of the hour to take snapshots for the NetApp volume."
}

variable "anf_backup_daily" {
  type        = number
  default     = 5
  description = "Number of daily backups to keep for the NetApp volume."
}

variable "anf_backup_weekly" {
  type        = number
  default     = 0
  description = "Number of weekly backups to keep for the NetApp volume."
}

variable "anf_backup_monthly" {
  type        = number
  default     = 0
  description = "Number of monthly backups to keep for the NetApp volume."
}

variable "replication_schedule" {
  type        = string
  default     = "hourly"
  description = "Replication schedule for the NetApp volume. Options: '_10minutely', 'hourly', or 'daily'."
}

variable "destination_zone" {
  type        = string
  default     = "2"
  description = "The target Availability Zone (e.g., '1', '2', '3') for the replica volume."
}