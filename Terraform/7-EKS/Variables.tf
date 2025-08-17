variable "AWS_REGION" {
  description = "AWS Region where resources will be created"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
  default     = "bia-eks-cluster"
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.28"
}

variable "endpoint_private_access" {
  description = "Habilitar acesso privado ao endpoint do cluster"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Habilitar acesso público ao endpoint do cluster"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "Lista de CIDRs que podem acessar o endpoint público"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_log_types" {
  description = "Lista de tipos de log do cluster para habilitar"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "encryption_config" {
  description = "Configuração de criptografia para o cluster"
  type = list(object({
    kms_key_arn = string
    resources   = list(string)
  }))
  default = []
}

variable "node_groups" {
  description = "Configuração dos node groups"
  type = map(object({
    instance_types             = list(string)
    ami_type                   = string
    capacity_type              = string
    disk_size                  = number
    desired_size               = number
    max_size                   = number
    min_size                   = number
    max_unavailable_percentage = number
    launch_template = optional(object({
      id      = string
      version = string
    }))
    remote_access = optional(object({
      ec2_ssh_key               = string
      source_security_group_ids = list(string)
    }))
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })))
    tags = map(string)
  }))
  
  default = {
    general = {
      instance_types             = ["t3.medium"]
      ami_type                   = "AL2_x86_64"
      capacity_type              = "ON_DEMAND"
      disk_size                  = 20
      desired_size               = 2
      max_size                   = 4
      min_size                   = 1
      max_unavailable_percentage = 25
      launch_template            = null
      remote_access              = null
      taints                     = null
      tags = {
        Environment = "dev"
        NodeGroup   = "general"
      }
    }
  }
}

variable "cluster_addons" {
  description = "Addons do cluster EKS"
  type = map(object({
    version                  = string
    resolve_conflicts        = string
    service_account_role_arn = optional(string)
  }))
  
  default = {
    "vpc-cni" = {
      version           = "v1.15.1-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
    "coredns" = {
      version           = "v1.10.1-eksbuild.5"
      resolve_conflicts = "OVERWRITE"
    }
    "kube-proxy" = {
      version           = "v1.28.2-eksbuild.2"
      resolve_conflicts = "OVERWRITE"
    }
    "aws-ebs-csi-driver" = {
      version           = "v1.24.0-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
    }
  }
}

variable "custom_policies" {
  description = "Políticas IAM customizadas para os nodes"
  type = map(object({
    Version = string
    Statement = list(object({
      Effect   = string
      Action   = list(string)
      Resource = list(string)
    }))
  }))
  default = {}
}

variable "enable_fargate" {
  description = "Habilitar Fargate para o cluster"
  type        = bool
  default     = false
}

variable "cluster_security_group_rules" {
  description = "Regras de security group para o cluster"
  type = object({
    ingress = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), [])
      security_groups = optional(list(string), [])
    }))
    egress = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), [])
      security_groups = optional(list(string), [])
    }))
  })
  
  default = {
    ingress = [
      {
        description = "HTTPS from nodes"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        security_groups = ["eks-nodes"]
      }
    ]
    egress = [
      {
        description = "All outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

variable "nodes_security_group_rules" {
  description = "Regras de security group para os nodes"
  type = object({
    ingress = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), [])
      security_groups = optional(list(string), [])
      self            = optional(bool, false)
    }))
    egress = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), [])
      security_groups = optional(list(string), [])
    }))
  })
  
  default = {
    ingress = [
      {
        description = "Node to node communication"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        self        = true
      },
      {
        description = "Cluster API to nodes"
        from_port   = 1025
        to_port     = 65535
        protocol    = "tcp"
        security_groups = ["eks-cluster"]
      },
      {
        description = "SSH access from dev SG"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        security_groups = ["bia-dev"]
      }
    ]
    egress = [
      {
        description = "All outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
}

variable "create_alb_security_group" {
  description = "Criar security group para ALB"
  type        = bool
  default     = true
}

variable "alb_security_group_rules" {
  description = "Regras de security group para ALB"
  type = object({
    ingress = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = optional(list(string), [])
      security_groups = optional(list(string), [])
    }))
  })
  
  default = {
    ingress = [
      {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        description = "To EKS nodes"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        security_groups = ["eks-nodes"]
      }
    ]
  }
}

variable "common_tags" {
  description = "Tags comuns para todos os recursos"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "DevOps-001"
    ManagedBy   = "Terraform"
    Owner       = "Junior"
  }
}
