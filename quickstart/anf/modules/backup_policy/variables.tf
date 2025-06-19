variable "parent_id" {
  type        = string
  description = "The NetApp Account resource ID to attach this backup policy to."
}

variable "policy_name" {
  type        = string
  default     = "anf_daily_only_policy"
  description = "The name of the backup policy."
}

variable "location" {
  type        = string
  description = "Azure location."
}

variable "properties" {
  type = object({
    enabled              = bool
    dailyBackupsToKeep   = number
    weeklyBackupsToKeep  = number
    monthlyBackupsToKeep = number
  })
  description = "Backup retention settings."
}
