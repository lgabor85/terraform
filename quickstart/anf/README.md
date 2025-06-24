# Azure NetApp Files

This template deploys an Azure NetApp Files.

## Terraform resource types

- [random_pet](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet)
- [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)
- [random_string](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)
- [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
- [azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
- [azurerm_netapp_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account)
- [azurerm_netapp_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool)
- [azurerm_netapp_volume](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume)

## Variables

| Name | Description | Default value |
|-|-|-|
| `resource_group_name_prefix` | Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription. | rg |
| `resource_group_location` | Location of the resource group. | westeurope |
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~>3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_anf_czr"></a> [anf\_czr](#module\_anf\_czr) | ./modules/czr | n/a |
| <a name="module_backup_policy"></a> [backup\_policy](#module\_backup\_policy) | ./modules/backup_policy | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_netapp_account.anf-account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |
| [azurerm_netapp_backup_vault.anf-backup-vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_backup_vault) | resource |
| [azurerm_netapp_pool.anf-pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |
| [azurerm_netapp_snapshot_policy.anf-snapshot-policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_snapshot_policy) | resource |
| [azurerm_netapp_volume.anf-volume](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume) | resource |
| [azurerm_resource_group.anf-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.anf-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.anf-vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_pet.rg_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_string.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anf-snapshots_to_keep"></a> [anf-snapshots\_to\_keep](#input\_anf-snapshots\_to\_keep) | Number of snapshots to keep for the NetApp volume. | `number` | `10` | no |
| <a name="input_anf_backup_daily"></a> [anf\_backup\_daily](#input\_anf\_backup\_daily) | Number of daily backups to keep for the NetApp volume. | `number` | `5` | no |
| <a name="input_anf_backup_monthly"></a> [anf\_backup\_monthly](#input\_anf\_backup\_monthly) | Number of monthly backups to keep for the NetApp volume. | `number` | `0` | no |
| <a name="input_anf_backup_weekly"></a> [anf\_backup\_weekly](#input\_anf\_backup\_weekly) | Number of weekly backups to keep for the NetApp volume. | `number` | `0` | no |
| <a name="input_anf_snapshot_hour"></a> [anf\_snapshot\_hour](#input\_anf\_snapshot\_hour) | Hour of the day to take snapshots for the NetApp volume. | `number` | `0` | no |
| <a name="input_anf_snapshot_minute"></a> [anf\_snapshot\_minute](#input\_anf\_snapshot\_minute) | Minute of the hour to take snapshots for the NetApp volume. | `number` | `0` | no |
| <a name="input_destination_zone"></a> [destination\_zone](#input\_destination\_zone) | The target Availability Zone (e.g., '1', '2', '3') for the replica volume. | `string` | `"2"` | no |
| <a name="input_prevent_volume_destruction"></a> [prevent\_volume\_destruction](#input\_prevent\_volume\_destruction) | Should an `azurerm_netapp_volume` be protected against deletion (intentionally or unintentionally)? Defaults to `true`. | `bool` | `false` | no |
| <a name="input_replication_schedule"></a> [replication\_schedule](#input\_replication\_schedule) | Replication schedule for the NetApp volume. Options: '\_10minutely', 'hourly', or 'daily'. | `string` | `"hourly"` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group. | `string` | `"westeurope"` | no |
| <a name="input_resource_group_name_prefix"></a> [resource\_group\_name\_prefix](#input\_resource\_group\_name\_prefix) | Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription. | `string` | `"rg"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_netapp_account_name"></a> [netapp\_account\_name](#output\_netapp\_account\_name) | n/a |
| <a name="output_netapp_pool_name"></a> [netapp\_pool\_name](#output\_netapp\_pool\_name) | n/a |
| <a name="output_netapp_volume_name"></a> [netapp\_volume\_name](#output\_netapp\_volume\_name) | n/a |
| <a name="output_replica_mirror_state"></a> [replica\_mirror\_state](#output\_replica\_mirror\_state) | Replication state of the destination volume (mirror status) |
| <a name="output_replica_volume_id"></a> [replica\_volume\_id](#output\_replica\_volume\_id) | Resource ID of the created destination (replica) volume |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
<!-- END_TF_DOCS -->