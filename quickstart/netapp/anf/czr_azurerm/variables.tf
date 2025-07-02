# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "location" {
  description = "The Azure location where all resources in this example should be created."
  default     = "West Europe"
}

variable "alt_location" {
  description = "The Azure location where the secondary volume will be created."
  default     = "West Europe"
}

variable "prefix" {
  description = "The prefix used for all resources used by this NetApp Volume"
  type        = string
  default     = "anfdemo"
}

variable "prevent_volume_destruction" {
  type        = bool
  default     = false
  description = "Should an `azurerm_netapp_volume` be protected against deletion (intentionally or unintentionally)? Defaults to `true`."
}

variable "daily_backups_to_keep" {
  type        = number
  default     = 35
  description = "The number of daily backups to keep for the NetApp Volume. Defaults to `30`."
}

variable "weekly_backups_to_keep" {
  type        = number
  default     = 0
  description = "The number of weekly backups to keep for the NetApp Volume. Defaults to `0`."
}

variable "monthly_backups_to_keep" {
  type        = number
  default     = 0
  description = "The number of monthly backups to keep for the NetApp Volume. Defaults to `0`."
}