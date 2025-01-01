variable "resource_suffix" {
  description = "Suffix for naming resources"
  type        = string
  default = "rnd123"
}

variable "location" {
  description = "The location where resources will be created"
  type        = string
    default     = "westeurope"
}