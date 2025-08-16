<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.22.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.repository-bia](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/ecr_repository) | resource |
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
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment; will be prefixed to all resources. | `string` | `"bia"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | `"KeyPar-072024"` | no |
| <a name="input_user_names"></a> [user\_names](#input\_user\_names) | Name of the User. | `list(string)` | <pre>[<br>  "XXX",<br>  "YYY",<br>  "ZZZ"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_repository_arn"></a> [ecr\_repository\_arn](#output\_ecr\_repository\_arn) | App ECR repository Information |
| <a name="output_ecr_repository_id"></a> [ecr\_repository\_id](#output\_ecr\_repository\_id) | App ECR repository Information |
| <a name="output_ecr_repository_name"></a> [ecr\_repository\_name](#output\_ecr\_repository\_name) | App ECR repository Information |
| <a name="output_ecr_repository_registry_id"></a> [ecr\_repository\_registry\_id](#output\_ecr\_repository\_registry\_id) | App ECR repository Information |
| <a name="output_ecr_repository_tags_all"></a> [ecr\_repository\_tags\_all](#output\_ecr\_repository\_tags\_all) | App ECR repository Information |
| <a name="output_ecr_repository_url"></a> [ecr\_repository\_url](#output\_ecr\_repository\_url) | App ECR repository Information |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
