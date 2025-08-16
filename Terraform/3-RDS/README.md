<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.22.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.86.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.db-Projeto](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_secretsmanager_secret.db_password_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.db_password_secret_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.db_master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [terraform_remote_state.sg](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autor"></a> [autor](#input\_autor) | Autor de edição. | `string` | n/a | yes |
| <a name="input_cliente"></a> [cliente](#input\_cliente) | Cliente do projeto. | `string` | n/a | yes |
| <a name="input_projeto"></a> [projeto](#input\_projeto) | Descrição do projeto. | `string` | n/a | yes |
| <a name="input_regiao"></a> [regiao](#input\_regiao) | Região onde a infraestrutura será criada. | `string` | n/a | yes |
| <a name="input_shortnameid"></a> [shortnameid](#input\_shortnameid) | Nome curto para identificação dos recursos na AWS | `string` | n/a | yes |
| <a name="input_app_count"></a> [app\_count](#input\_app\_count) | n/a | `number` | `2` | no |
| <a name="input_cdirs_acesso_remoto"></a> [cdirs\_acesso\_remoto](#input\_cdirs\_acesso\_remoto) | n/a | `list(any)` | <pre>[<br>  "0.0.0.0/0",<br>  "187.180.212.28/32",<br>  "200.181.118.98/32"<br>]</pre> | no |
| <a name="input_dynamic_scaling"></a> [dynamic\_scaling](#input\_dynamic\_scaling) | Enable/disable dynamic scaling of the auto scaling group. | `bool` | `false` | no |
| <a name="input_dynamic_scaling_adjustment"></a> [dynamic\_scaling\_adjustment](#input\_dynamic\_scaling\_adjustment) | The adjustment in number of instances for dynamic scaling. | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"bia"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | `"KeyPar-072024"` | no |
| <a name="input_user_names"></a> [user\_names](#input\_user\_names) | Name of the User. | `list(string)` | <pre>[<br>  "XXX",<br>  "YYY",<br>  "ZZZ"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_arn"></a> [db\_arn](#output\_db\_arn) | n/a |
| <a name="output_db_db_address"></a> [db\_db\_address](#output\_db\_db\_address) | n/a |
| <a name="output_db_db_engine"></a> [db\_db\_engine](#output\_db\_db\_engine) | n/a |
| <a name="output_db_db_id"></a> [db\_db\_id](#output\_db\_db\_id) | n/a |
| <a name="output_db_db_identifier"></a> [db\_db\_identifier](#output\_db\_db\_identifier) | n/a |
| <a name="output_db_db_name"></a> [db\_db\_name](#output\_db\_db\_name) | n/a |
| <a name="output_db_db_password"></a> [db\_db\_password](#output\_db\_db\_password) | n/a |
| <a name="output_db_db_port"></a> [db\_db\_port](#output\_db\_db\_port) | n/a |
| <a name="output_db_db_username"></a> [db\_db\_username](#output\_db\_db\_username) | n/a |
| <a name="output_db_end_point"></a> [db\_end\_point](#output\_db\_end\_point) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
