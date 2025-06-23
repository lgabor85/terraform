
# ─────────────────────────────────────────────────────────┐
# Nested modules for Azure NetApp Files (ANF) backup policy|
# ─────────────────────────────────────────────────────────┘
# This module creates a backup policy for ANF volumes as a workaround for the current limitations in the AzureRM provider.
# see: https://github.com/hashicorp/terraform-provider-azurerm/issues/29901
module "backup_policy" {
  source    = "./modules/backup_policy"
  parent_id = azurerm_netapp_account.anf-account.id
  location  = azurerm_netapp_account.anf-account.location
  properties = {
    enabled              = true
    dailyBackupsToKeep   = var.anf_backup_daily
    weeklyBackupsToKeep  = var.anf_backup_weekly
    monthlyBackupsToKeep = var.anf_backup_monthly
  }
}

# This module sets up a Cross-Zone Replication (CZR) for Azure NetApp Files volumes.
module "anf_czr" {
  source                = "./modules/czr"
  source_volume_id      = azurerm_netapp_volume.anf-volume.id
  destination_zone      = var.destination_zone
  replication_schedule  = var.replication_schedule
  volume_path           = azurerm_netapp_volume.anf-volume.volume_path
  subnet_id             = azurerm_subnet.anf-subnet.id
  capacity_pool_id      = azurerm_netapp_pool.anf-pool.id
  service_level         = azurerm_netapp_pool.anf-pool.service_level
  usage_threshold       = 1000
  location              = azurerm_resource_group.anf-rg.location
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

# Create NetApp Volume
resource "azurerm_netapp_volume" "anf-volume" {
  name                = "volume-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.anf-rg.name
  account_name        = azurerm_netapp_account.anf-account.name
  pool_name           = azurerm_netapp_pool.anf-pool.name
  location            = azurerm_resource_group.anf-rg.location
  volume_path         = "volume-${random_string.name.result}"
  protocols           = ["NFSv4.1"]
  service_level       = "Standard"
  subnet_id           = azurerm_subnet.anf-subnet.id
  zone                 = "1"  # Specify the Availability Zone (e.g., "1", "2", "3")
  storage_quota_in_gb = 100
  lifecycle {
    ignore_changes = [ all ]             # Ignore replication changes managed by AzAPI:contentReference[oaicite:11]{index=11}
    # prevent_destroy = true                           # Prevent destroying source volume accidentally:contentReference[oaicite:12]{index=12}
  }
  export_policy_rule {
    rule_index        = 1
    allowed_clients   = ["0.0.0.0/0"]
    protocols_enabled = ["NFSv4.1"]
    unix_read_only    = false
    unix_read_write   = true
  }
  # Enabling backup policy
  data_protection_backup_policy {
    backup_vault_id  = azurerm_netapp_backup_vault.anf-backup-vault.id
    backup_policy_id = module.backup_policy.policy_id
    policy_enabled   = true
  }
}

# Create NetApp Snapshot Policy
resource "azurerm_netapp_snapshot_policy" "anf-snapshot-policy" {
  name                = "snapshot-policy-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.anf-rg.name
  account_name        = azurerm_netapp_account.anf-account.name
  location            = azurerm_resource_group.anf-rg.location
  enabled             = true

  daily_schedule {
    snapshots_to_keep = var.anf-snapshots_to_keep
    hour              = var.anf_snapshot_hour
    minute            = var.anf_snapshot_minute
  }
}

# Create NetApp Backup Vault
resource "azurerm_netapp_backup_vault" "anf-backup-vault" {
  name                = "backup-vault-${random_string.name.result}"
  resource_group_name = azurerm_resource_group.anf-rg.name
  account_name        = azurerm_netapp_account.anf-account.name
  location            = azurerm_resource_group.anf-rg.location
}
