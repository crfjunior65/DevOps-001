variable "environment" {
  description = "Ambiente de deploy (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_name" {
  description = "Nome da VPC"
  type        = string
  default     = "DevOps-vpc"
}

variable "vpc_cidr" {
  description = "Bloco CIDR para a VPC"
  type        = string
  default     = "10.12.0.0/16"
}

# variable "azs" {
#   description = "Zonas de Disponibilidade"
#   type        = list(string)
#   #default     = ["${var.AWS_REGION}a", "${var.AWS_REGION}b"]
#   #default     = ["us-east-2a", "us-east-2b"]
#}

variable "public_subnets" {
  description = "CIDRs para sub-redes públicas"
  type        = list(string)
  default     = ["10.12.101.0/24", "10.12.102.0/24"]
}

variable "private_subnets" {
  description = "CIDRs para sub-redes privadas"
  type        = list(string)
  default     = ["10.12.201.0/24", "10.12.202.0/24"]
}

variable "database_subnets" {
  description = "CIDRs para sub-redes de banco de dados"
  type        = list(string)
  default     = ["10.12.21.0/24", "10.12.22.0/24"]
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Usar um único NAT Gateway para todas as AZs"
  type        = bool
  default     = false
}

variable "owner" {
  description = "Owner/team responsible for the resource"
  type        = string
  default     = "DevOps-Team" # Default value (override via terraform.tfvars)
}

variable "AWS_REGION" {
  description = "AWS Region where resources will be created"
  type        = string
  default     = "us-east-2"
}