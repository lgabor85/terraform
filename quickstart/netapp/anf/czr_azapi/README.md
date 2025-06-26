## Requirements

The following requirements are needed by this module:

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~>4)

- <a name="requirement_random"></a> [random](#requirement\_random) (~>3)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~>4)

- <a name="provider_random"></a> [random](#provider\_random) (~>3)

## Modules

The following Modules are called:

### <a name="module_anf_czr"></a> [anf\_czr](#module\_anf\_czr)

Source: ./modules/czr

Version:

## Resources

The following resources are used by this module:

- [azurerm_netapp_account.anf-account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) (resource)
- [azurerm_netapp_backup_vault.anf-backup-vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_backup_vault) (resource)
- [azurerm_netapp_pool.anf-pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) (resource)
- [azurerm_resource_group.anf-rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [azurerm_subnet.anf-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) (resource)
- [azurerm_virtual_network.anf-vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)
- [random_pet.rg_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) (resource)
- [random_string.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_anf-snapshots_to_keep"></a> [anf-snapshots\_to\_keep](#input\_anf-snapshots\_to\_keep)

Description: Number of snapshots to keep for the NetApp volume.

Type: `number`

Default: `10`

### <a name="input_anf_backup_daily"></a> [anf\_backup\_daily](#input\_anf\_backup\_daily)

Description: Number of daily backups to keep for the NetApp volume.

Type: `number`

Default: `5`

### <a name="input_anf_backup_monthly"></a> [anf\_backup\_monthly](#input\_anf\_backup\_monthly)

Description: Number of monthly backups to keep for the NetApp volume.

Type: `number`

Default: `0`

### <a name="input_anf_backup_weekly"></a> [anf\_backup\_weekly](#input\_anf\_backup\_weekly)

Description: Number of weekly backups to keep for the NetApp volume.

Type: `number`

Default: `0`

### <a name="input_anf_snapshot_hour"></a> [anf\_snapshot\_hour](#input\_anf\_snapshot\_hour)

Description: Hour of the day to take snapshots for the NetApp volume.

Type: `number`

Default: `0`

### <a name="input_anf_snapshot_minute"></a> [anf\_snapshot\_minute](#input\_anf\_snapshot\_minute)

Description: Minute of the hour to take snapshots for the NetApp volume.

Type: `number`

Default: `0`

### <a name="input_destination_zone"></a> [destination\_zone](#input\_destination\_zone)

Description: The target Availability Zone (e.g., '1', '2', '3') for the replica volume.

Type: `string`

Default: `"2"`

### <a name="input_prevent_volume_destruction"></a> [prevent\_volume\_destruction](#input\_prevent\_volume\_destruction)

Description: Should an `azurerm_netapp_volume` be protected against deletion (intentionally or unintentionally)? Defaults to `true`.

Type: `bool`

Default: `false`

### <a name="input_replication_schedule"></a> [replication\_schedule](#input\_replication\_schedule)

Description: Replication schedule for the NetApp volume. Options: '\_10minutely', 'hourly', or 'daily'.

Type: `string`

Default: `"hourly"`

### <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location)

Description: Location of the resource group.

Type: `string`

Default: `"westeurope"`

### <a name="input_resource_group_name_prefix"></a> [resource\_group\_name\_prefix](#input\_resource\_group\_name\_prefix)

Description: Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription.

Type: `string`

Default: `"rg"`

## Outputs

The following outputs are exported:

### <a name="output_netapp_account_name"></a> [netapp\_account\_name](#output\_netapp\_account\_name)

Description: n/a

### <a name="output_netapp_pool_name"></a> [netapp\_pool\_name](#output\_netapp\_pool\_name)

Description: n/a

### <a name="output_replica_volume_id"></a> [replica\_volume\_id](#output\_replica\_volume\_id)

Description: Resource ID of the created destination (replica) volume

### <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name)

Description: n/a
