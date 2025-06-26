## Requirements

The following requirements are needed by this module:

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~>4.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~>3.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~>4.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [azurerm_netapp_account.example_primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) (resource)
- [azurerm_netapp_pool.example_primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) (resource)
- [azurerm_netapp_volume.example_primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume) (resource)
- [azurerm_netapp_volume.example_secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume) (resource)
- [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [azurerm_subnet.example_primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) (resource)
- [azurerm_virtual_network.example_primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) (resource)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_alt_location"></a> [alt\_location](#input\_alt\_location)

Description: The Azure location where the secondary volume will be created.

Type: `string`

Default: `"West Europe"`

### <a name="input_location"></a> [location](#input\_location)

Description: The Azure location where all resources in this example should be created.

Type: `string`

Default: `"West Europe"`

### <a name="input_prefix"></a> [prefix](#input\_prefix)

Description: The prefix used for all resources used by this NetApp Volume

Type: `string`

Default: `"anfdemo"`

### <a name="input_prevent_volume_destruction"></a> [prevent\_volume\_destruction](#input\_prevent\_volume\_destruction)

Description: Should an `azurerm_netapp_volume` be protected against deletion (intentionally or unintentionally)? Defaults to `true`.

Type: `bool`

Default: `false`

## Outputs

The following outputs are exported:

### <a name="output_netapp_account_name"></a> [netapp\_account\_name](#output\_netapp\_account\_name)

Description: value of the NetApp account name

### <a name="output_netapp_pool_name"></a> [netapp\_pool\_name](#output\_netapp\_pool\_name)

Description: value of the NetApp pool name

### <a name="output_netapp_volume_name"></a> [netapp\_volume\_name](#output\_netapp\_volume\_name)

Description: value of the NetApp volume name

### <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name)

Description: value of the resource group name
