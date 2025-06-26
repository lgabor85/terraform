variable "source_volume_name" {
  description = "Name of the existing source NetApp volume to replicate from"
  type        = string
}

variable "destination_volume_name" {
  description = "Name of the destination NetApp volume to create for replication"
  type        = string
}

variable "replication_schedule" {
  description = "Replication schedule: '_10minutely', 'hourly', or 'daily' (10-minute schedule not allowed for large volumes:contentReference[oaicite:3]{index=3})"
  default     = "hourly"
  type        = string
}

variable "volume_path" {
  description = "Unique file path (mount target path) for the destination volume (also used as volume name)"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the ANF volume (should be in same VNet and region as NetApp account)"
  type        = string
}

variable "pool_name" {
  description = "Name of the Azure NetApp Files capacity pool for the source volume"
  type        = string
}

variable "capacity_pool_id" {
  description = "Resource ID of the Azure NetApp Files capacity pool for the destination volume"
  type        = string
}

variable "service_level" {
  description = "Service level for the destination volume (e.g., 'Premium', 'Standard', 'Ultra')"
  type        = string
}

variable "usage_threshold" {
  description = "Provisioned capacity (in GiB) for the destination volume"
  type        = number
}

variable "location" {
  description = "Azure region of the NetApp account (e.g., 'eastus') – should match the source volume's region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the NetApp account and volumes are created"
  type        = string
}

variable "source_zone" {
  description = "Availability Zone for the source volume (e.g., '1', '2', '3')"
  type        = string
}

variable "dest_zone" {
  description = "Availability Zone for the destination volume (e.g., '1', '2', '3')"
  type        = string  
}

variable "storage_quota_in_gb" {
  description = "Storage quota for the source volume in GiB"
  type        = number
}

variable "account_name" {
  description = "Name of the Azure NetApp Files account where the source volume is located"
  type        = string
}

variable "account_id" {
  description = "Resource ID of the Azure NetApp Files account"
  type        = string
}

variable "dest_quota_gb" {
  description = "Provisioned capacity for the destination volume in GiB"
  type        = number
}

variable "protocols" {
  description = "List of protocols enabled for the destination volume (e.g., ['NFSv4.1'])"
  type        = list(string)
  default     = ["NFSv4.1"] # Default to NFSv4.1, can be overridden
}

variable "backup_vault_id" {
  description = "ID of the NetApp backup vault to use for backups"
  type        = string
}

variable "anf_backup_daily" {
  description = "Number of daily backups to keep in the backup policy"
  type        = number
  default     = 7
}

variable "anf_backup_weekly" {
  description = "Number of weekly backups to keep in the backup policy"
  type        = number
  default     = 0
}

variable "anf_backup_monthly" {
  description = "Number of monthly backups to keep in the backup policy"
  type        = number
  default     = 0
}