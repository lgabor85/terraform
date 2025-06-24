
# ───────────────────────────────────────────┐
# Nested modules for Azure NetApp Files (ANF)|
# ───────────────────────────────────────────┘
# This module sets up a Cross-Zone Replication (CZR) for Azure NetApp Files volumes.
module "anf_czr" {
  source              = "./modules/czr"
  account_name        = azurerm_netapp_account.anf-account.name
  account_id          = azurerm_netapp_account.anf-account.id
  resource_group_name = azurerm_resource_group.anf-rg.name
  capacity_pool_id    = azurerm_netapp_pool.anf-pool.id
  pool_name           = azurerm_netapp_pool.anf-pool.name
  location            = azurerm_resource_group.anf-rg.location
  subnet_id           = azurerm_subnet.anf-subnet.id
  usage_threshold     = 2199023255552
  backup_vault_id     = azurerm_netapp_backup_vault.anf-backup-vault.id

  # Required attributes
  source_zone        = "1"
  dest_zone          = "2" # Change as needed for your setup
  source_volume_name = "volume-${random_string.name.result}-src"
  dest_quota_gb      = 2199023255552

  destination_volume_name = "volume-${random_string.name.result}-dest"
  storage_quota_in_gb     = 100
  volume_path             = "myvolume01"
  service_level           = "Standard"
  protocols               = ["NFSv4.1"]
  # Add any other required variables for your module here
}

# ────────────────────────────────────────────────────────────────┐
# Main resources to create Azure NetApp Files (ANF) infrastructure|
# ────────────────────────────────────────────────────────────────┘
# Create random pet name to ensure unique resource name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

# Create Resource Group
resource "azurerm_resource_group" "anf-rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

# Random String for unique naming of resources
resource "random_string" "name" {
  length  = 8
  special = false
  upper   = false
  lower   = true
  numeric = false
}

# Create Virtual Network
resource "azurerm_virtual_network" "anf-vnet" {
  name                = "vnet-${random_string.name.result}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.anf-rg.location
  resource_group_name = azurerm_resource_group.anf-rg.name
}

# Create Subnet for NetApp
resource "azurerm_subnet" "anf-subnet" {
  name                 = "subnet-${random_string.name.result}"
  resource_group_name  = azurerm_resource_group.anf-rg.name
  virtual_network_name = azurerm_virtual_network.anf-vnet.name
  address_prefixes     = ["10.0.0.0/24"]
  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.Netapp/volumes"
      actions = [
        "Microsoft.Network/networkinterfaces/*",
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }
}

# Create NetApp Account
resource "azurerm_netapp_account" "anf-account" {
  name                = "account-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.anf-rg.name
  location            = azurerm_resource_group.anf-rg.location
}

# Create NetApp Pool
resource "azurerm_netapp_pool" "anf-pool" {
  name                = "pool-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.anf-rg.name
  account_name        = azurerm_netapp_account.anf-account.name
  location            = azurerm_resource_group.anf-rg.location
  service_level       = "Standard"
  size_in_tb          = 4
}

# Create NetApp Backup Vault
resource "azurerm_netapp_backup_vault" "anf-backup-vault" {
  name                = "backup-vault-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.anf-rg.name
  account_name        = azurerm_netapp_account.anf-account.name
  location            = azurerm_resource_group.anf-rg.location
}