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
| <a name="provider_aws.sa-1"></a> [aws.sa-1](#provider\_aws.sa-1) | 5.22.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.ec2_bastianhost](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/instance) | resource |
| [aws_key_pair.deployer](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/key_pair) | resource |
| [aws_key_pair.deployer_sa-1](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/resources/key_pair) | resource |
| [aws_ami.amazon_linux2](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/ami) | data source |
| [aws_ami.amazon_linux_2023](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/ami) | data source |
| [aws_ami.amazon_linux_2023_sa-1](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu_linux](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu_linux_2204](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/ami) | data source |
| [aws_ami.windows_server_2022](https://registry.terraform.io/providers/hashicorp/aws/5.22.0/docs/data-sources/ami) | data source |
| [terraform_remote_state.iam](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.rds](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
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
| <a name="input_amis"></a> [amis](#input\_amis) | n/a | `map(any)` | <pre>{<br>  "Ubnt-us-east-1": "ami-0261755bbcb8c4a84",<br>  "Ubnt-us-east-2": "ami-0430580de6244e02e"<br>}</pre> | no |
| <a name="input_app_count"></a> [app\_count](#input\_app\_count) | n/a | `number` | `2` | no |
| <a name="input_cdirs_acesso_remoto"></a> [cdirs\_acesso\_remoto](#input\_cdirs\_acesso\_remoto) | n/a | `list(any)` | <pre>[<br>  "187.180.212.28/32",<br>  "200.181.118.98/32"<br>]</pre> | no |
| <a name="input_dynamic_scaling"></a> [dynamic\_scaling](#input\_dynamic\_scaling) | Enable/disable dynamic scaling of the auto scaling group. | `bool` | `false` | no |
| <a name="input_dynamic_scaling_adjustment"></a> [dynamic\_scaling\_adjustment](#input\_dynamic\_scaling\_adjustment) | The adjustment in number of instances for dynamic scaling. | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment; will be prefixed to all resources. | `string` | `"Projeto"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `string` | `"aws-key-terraform"` | no |
| <a name="input_key_name_sa-1"></a> [key\_name\_sa-1](#input\_key\_name\_sa-1) | n/a | `string` | `"aws-key-terraform_sa-1"` | no |
| <a name="input_user_names"></a> [user\_names](#input\_user\_names) | Name of the User. | `list(string)` | <pre>[<br>  "XXX",<br>  "YYY",<br>  "ZZZ"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_EC2_bia_dev_sg_ids"></a> [EC2\_bia\_dev\_sg\_ids](#output\_EC2\_bia\_dev\_sg\_ids) | Ids dos SGs |
| <a name="output_ami_amazon2"></a> [ami\_amazon2](#output\_ami\_amazon2) | n/a |
| <a name="output_ami_amazon_2023"></a> [ami\_amazon\_2023](#output\_ami\_amazon\_2023) | n/a |
| <a name="output_ami_linux_amz_2023"></a> [ami\_linux\_amz\_2023](#output\_ami\_linux\_amz\_2023) | AMI do Amazom Linux 2023. |
| <a name="output_ami_ubuntu"></a> [ami\_ubuntu](#output\_ami\_ubuntu) | n/a |
| <a name="output_ami_ubuntu_2204"></a> [ami\_ubuntu\_2204](#output\_ami\_ubuntu\_2204) | n/a |
| <a name="output_ami_win2022"></a> [ami\_win2022](#output\_ami\_win2022) | AMI do Windows Server 2022 |
| <a name="output_autor"></a> [autor](#output\_autor) | Autor de edição. |
| <a name="output_bastion_instance_id"></a> [bastion\_instance\_id](#output\_bastion\_instance\_id) | The instance ID of the bastion host. |
| <a name="output_bastion_key_name"></a> [bastion\_key\_name](#output\_bastion\_key\_name) | The key name associated with the bastion host. |
| <a name="output_bastion_private_ip"></a> [bastion\_private\_ip](#output\_bastion\_private\_ip) | The private IP address of the bastion host. |
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | The public IP address of the bastion host. |
| <a name="output_bastion_sg_ids"></a> [bastion\_sg\_ids](#output\_bastion\_sg\_ids) | The security group IDs associated with the bastion host. |
| <a name="output_cliente"></a> [cliente](#output\_cliente) | Cliente do projeto. |
| <a name="output_id_instancia"></a> [id\_instancia](#output\_id\_instancia) | n/a |
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | Nome da chave SSH para acesso às instâncias. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
| <a name="output_projeto"></a> [projeto](#output\_projeto) | Descrição do projeto. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
| <a name="output_regiao"></a> [regiao](#output\_regiao) | Região onde a infraestrutura será criada. |
| <a name="output_shortnameid"></a> [shortnameid](#output\_shortnameid) | Nome curto para identificação dos recursos na AWS |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
