output "vpc_name" {
  description = "Id da VPC"
  value       = module.vpc.name
}

output "vpc_azs_id" {
  description = "Relacai Ids das AZs"
  value       = module.vpc.azs[*] #private_subnets[*]
}

#module.vpc.public_subnets[0]
output "vpc_public_subnets_id" {
  description = "SubNets Publica"
  value       = module.vpc.public_subnets[*]
}

#module.vpc.public_subnets[0]
output "vpc_private_subnets_id" {
  description = "Relacai Ids das SubNets Privadas"
  value       = module.vpc.private_subnets[*]
}

#database_subnet_arns
output "vpc_database_subnet_arns" {
  value = module.vpc.database_subnet_arns
}

#private_subnets_cidr_blocks
output "vpc_private_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}
#public_subnets_cidr_blocks
output "vpc_public_subnets_cidr_blocks" {
  value = module.vpc.public_subnets_cidr_blocks
}
#vpc_cidr_block
output "vpc_vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}
#vpc_id
output "vpc_vpc_id" {
  value = module.vpc.vpc_id
}
output "vpc_db_subnet_grp_name" {
  value = module.vpc.database_subnet_group_name
}
