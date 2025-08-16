module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = format("%s-%s", var.vpc_name, var.environment)
  cidr = var.vpc_cidr

  azs              = local.all_azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets

  enable_nat_gateway = var.environment == "prod" ? true : false
  #enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  enable_dns_hostnames   = true
  enable_vpn_gateway     = false
  one_nat_gateway_per_az = false

  create_database_subnet_group       = true
  create_database_subnet_route_table = true
  create_igw                         = true

  public_subnet_tags = {
    Name = "SubNet-Public-${var.environment}"
  }

  private_subnet_tags = {
    Name = "SubNet-Private-${var.environment}"
  }

  database_subnet_tags = {
    Name = "SubNet-DataBase-${var.environment}"
  }

  tags = {
    #local.common_tags
    Terraform   = "true"
    Environment = "Projeto-${var.environment}"
    Management  = "Terraform"
  }

  # Tags globais (herdadas por todos os recursos da VPC)

}