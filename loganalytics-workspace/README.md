<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.11 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.76.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | = 2.76.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_log_analytics_workspace.log_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/2.76.0/docs/resources/log_analytics_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | Azure region for deployment of resources. | `string` | `"dev"` | no |
| <a name="input_log_workspace_map"></a> [log\_workspace\_map](#input\_log\_workspace\_map) | (Required) Map of log analytics workspaces and their details. | <pre>map(object({<br>    location                    = string<br>    resource_group              = string<br>    retention_in_days           = string<br>    sku                         = string<br>    custom_tags                 = map(string)<br>    validate_log_workspace_name = bool<br>  }))</pre> | n/a | yes |
| <a name="input_team_name"></a> [team\_name](#input\_team\_name) | (Required) String denoting the team responsible for the resource group. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_workspace_list"></a> [log\_workspace\_list](#output\_log\_workspace\_list) | Returns a list of names of log analytics workspace(s) created/deleted |
| <a name="output_team_name"></a> [team\_name](#output\_team\_name) | n/a |
<!-- END_TF_DOCS -->