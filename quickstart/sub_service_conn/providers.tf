# The azurerm remote backend is configured with a backend file created by the pipeline to dynamically set the state file name
# workaround for: https://github.com/hashicorp/terraform/issues/13022
terraform {
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
    }
  }
}

provider "azuredevops" {
  org_service_url       = "https://dev.azure.com/TOPdeskSaaS/"
  personal_access_token = var.personal_access_token
}
