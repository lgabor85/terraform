# Terraform Version: 0.13.5
# Terraform Configuration File
# This file is used to create the Azure Resource Group and Managed Identity
# The Managed Identity is used to authenticate the Azure Function App to the Azure Key Vault

data "azurerm_client_config" "current" {}


# Create an Azure Resource Group

resource "azurerm_resource_group" "rg" {
	name		=	"rg${var.resource_suffix}"
	location	=	var.location
}

# Create an Azure Managed Identity
resource "azurerm_user_assigned_identity" "mi" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "mi${var.resource_suffix}"
  
}

# Create the role assignment for the Managed Identity
resource "azurerm_role_assignment" "login" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.mi.principal_id
  
}

# 
