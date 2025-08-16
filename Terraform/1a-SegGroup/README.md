<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.95.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.bia-alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bia-build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bia-db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bia-dev](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bia-dev-mssql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bia-ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bia-web](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.mssql-db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.windows_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"bia"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_bia_alb"></a> [sg\_bia\_alb](#output\_sg\_bia\_alb) | SG Acesso a Instancia Id |
| <a name="output_sg_bia_db"></a> [sg\_bia\_db](#output\_sg\_bia\_db) | SG Acesso a Instancia Id |
| <a name="output_sg_bia_dev"></a> [sg\_bia\_dev](#output\_sg\_bia\_dev) | SG Acesso a Instancia Id |
| <a name="output_sg_bia_dev_mssql"></a> [sg\_bia\_dev\_mssql](#output\_sg\_bia\_dev\_mssql) | SG Acesso a Instancia Id |
| <a name="output_sg_bia_ec2"></a> [sg\_bia\_ec2](#output\_sg\_bia\_ec2) | SG Acesso a Instancia Id |
| <a name="output_sg_bia_web"></a> [sg\_bia\_web](#output\_sg\_bia\_web) | SG Acesso a Instancia Id |
| <a name="output_sg_mssql_db"></a> [sg\_mssql\_db](#output\_sg\_mssql\_db) | SG Acesso a Instancia Id |
| <a name="output_sg_windows"></a> [sg\_windows](#output\_sg\_windows) | SG Acesso a RDP |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
