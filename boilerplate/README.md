# boilerplate

Boilerplate module can be used either as a starting point for new module or 
used "as-is" to be augmented with the terraform code in the terragrunt repository
 
See: https://wiki.barco.com/display/DEVOPS/Terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 2.46 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS account to hold the state file buckets | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to deploy to (e.g. eu-west-1) | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | `"dev"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Resources owner | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_comment"></a> [comment](#output\_comment) | n/a |
| <a name="output_tags"></a> [tags](#output\_tags) | module output code (if any) goes here |
<!-- END_TF_DOCS -->