<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.22.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.1.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"bia"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpc_azs_id"></a> [vpc\_azs\_id](#output\_vpc\_azs\_id) | Relacai Ids das AZs |
| <a name="output_vpc_database_subnet_arns"></a> [vpc\_database\_subnet\_arns](#output\_vpc\_database\_subnet\_arns) | database\_subnet\_arns |
| <a name="output_vpc_db_subnet_grp_name"></a> [vpc\_db\_subnet\_grp\_name](#output\_vpc\_db\_subnet\_grp\_name) | n/a |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | Id da VPC |
| <a name="output_vpc_private_subnets_cidr_blocks"></a> [vpc\_private\_subnets\_cidr\_blocks](#output\_vpc\_private\_subnets\_cidr\_blocks) | private\_subnets\_cidr\_blocks |
| <a name="output_vpc_private_subnets_id"></a> [vpc\_private\_subnets\_id](#output\_vpc\_private\_subnets\_id) | Relacai Ids das SubNets Privadas |
| <a name="output_vpc_public_subnets_cidr_blocks"></a> [vpc\_public\_subnets\_cidr\_blocks](#output\_vpc\_public\_subnets\_cidr\_blocks) | public\_subnets\_cidr\_blocks |
| <a name="output_vpc_public_subnets_id"></a> [vpc\_public\_subnets\_id](#output\_vpc\_public\_subnets\_id) | SubNets Publica |
| <a name="output_vpc_vpc_cidr_block"></a> [vpc\_vpc\_cidr\_block](#output\_vpc\_vpc\_cidr\_block) | vpc\_cidr\_block |
| <a name="output_vpc_vpc_id"></a> [vpc\_vpc\_id](#output\_vpc\_vpc\_id) | vpc\_id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
