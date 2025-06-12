terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "~> 1.5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/lgaborDemoOrg"
  personal_access_token = "$ARM_AZURE_DEVOPS_PAT"
}

provider "azurerm" {
  features {}
}