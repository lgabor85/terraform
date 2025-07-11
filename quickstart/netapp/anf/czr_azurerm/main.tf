# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "example_primary" {
  name                = "${var.prefix}-virtualnetwork-primary"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example_primary" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example_primary.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "testdelegation"

    service_delegation {
      name    = "Microsoft.Netapp/volumes"
      actions = ["Microsoft.Network/networkinterfaces/*", "Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_netapp_account" "example_primary" {
  name                = "${var.prefix}-netappaccount-primary"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_netapp_pool" "example_primary" {
  name                = "${var.prefix}-netapppool-primary"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_netapp_account.example_primary.name
  service_level       = "Standard"
  size_in_tb          = 4
}

resource "azurerm_netapp_backup_vault" "anf_backup_vault" {
  name                = "${var.prefix}-anf-backup-vault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_netapp_account.example_primary.name
}

resource "azurerm_netapp_backup_policy" "anf_backup_policy" {
  name                = "${var.prefix}-anf-backup-policy"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_netapp_account.example_primary.name

  enabled                 = true
  daily_backups_to_keep   = var.daily_backups_to_keep
  weekly_backups_to_keep  = var.weekly_backups_to_keep
  monthly_backups_to_keep = var.monthly_backups_to_keep

}




resource "azurerm_netapp_volume" "example_primary" {
  lifecycle {
    prevent_destroy = false
  }

  name                = "${var.prefix}-netappvolume-primary"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_netapp_account.example_primary.name
  pool_name           = azurerm_netapp_pool.example_primary.name
  volume_path         = "${var.prefix}-netappvolume"
  service_level       = "Standard"
  protocols           = ["NFSv3"]
  subnet_id           = azurerm_subnet.example_primary.id
  storage_quota_in_gb = 100
  zone                = "1"

  export_policy_rule {
    rule_index        = 1
    allowed_clients   = ["0.0.0.0/0"]
    protocols_enabled = ["NFSv3"]
    unix_read_only    = false
    unix_read_write   = true
  }

  data_protection_backup_policy {
    backup_vault_id  = azurerm_netapp_backup_vault.anf_backup_vault.id
    backup_policy_id = azurerm_netapp_backup_policy.anf_backup_policy.id
    policy_enabled   = true
  }
}

resource "azurerm_netapp_volume" "example_secondary" {
  lifecycle {
    prevent_destroy = false
  }

  depends_on = [azurerm_netapp_volume.example_primary]

  name                = "${var.prefix}-netappvolume-secondary"
  location            = var.alt_location
  resource_group_name = azurerm_resource_group.example.name
  account_name        = azurerm_netapp_account.example_primary.name
  pool_name           = azurerm_netapp_pool.example_primary.name
  volume_path         = "${var.prefix}-netappvolume-secondary"
  service_level       = "Standard"
  protocols           = ["NFSv3"]
  subnet_id           = azurerm_subnet.example_primary.id
  storage_quota_in_gb = 100
  zone                = "2"

  export_policy_rule {
    rule_index        = 1
    allowed_clients   = ["0.0.0.0/0"]
    protocols_enabled = ["NFSv3"]
    unix_read_only    = false
    unix_read_write   = true
  }

  data_protection_replication {
    endpoint_type             = "dst"
    remote_volume_location    = azurerm_resource_group.example.location
    remote_volume_resource_id = azurerm_netapp_volume.example_primary.id
    replication_frequency     = "10minutes"
  }
}
