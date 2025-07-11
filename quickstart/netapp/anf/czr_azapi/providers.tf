terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
}

provider "azurerm" {
  features {

    # NOTICE: To prevent accidental deletion of the volume, set `var.prevent_volume_destruction`'s default value to to `true`
    netapp {
      prevent_volume_destruction = var.prevent_volume_destruction
    }
  }
}