variable "source_volume_id" {
  description = "Resource ID of the existing source NetApp volume to replicate from"
  type        = string
}

variable "destination_zone" {
  description = "The target Availability Zone (e.g., '1', '2', '3') for the replica volume"
  type        = string
}

variable "replication_schedule" {
  description = "Replication schedule: '_10minutely', 'hourly', or 'daily' (10-minute schedule not allowed for large volumes:contentReference[oaicite:3]{index=3})"
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