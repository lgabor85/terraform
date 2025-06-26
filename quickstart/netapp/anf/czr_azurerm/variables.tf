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