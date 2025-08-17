# Security Group para EKS Cluster
resource "aws_security_group" "eks_cluster" {
  name        = "${var.cluster_name}-cluster-sg"
  description = "Security group for EKS cluster control plane"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  # Dynamic block para regras de ingress
  dynamic "ingress" {
    for_each = var.cluster_security_group_rules.ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = lookup(ingress.value, "cidr_blocks", [])
      # Referência direta para evitar dependência circular
      security_groups = length(lookup(ingress.value, "security_groups", [])) > 0 ? [
        for sg_name in ingress.value.security_groups : 
          sg_name == "eks-nodes" ? aws_security_group.eks_nodes.id : null
      ] : []
    }
  }

  # Dynamic block para regras de egress
  dynamic "egress" {
    for_each = var.cluster_security_group_rules.egress
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = lookup(egress.value, "cidr_blocks", [])
      security_groups = length(lookup(egress.value, "security_groups", [])) > 0 ? [
        for sg_name in egress.value.security_groups : 
          sg_name == "eks-nodes" ? aws_security_group.eks_nodes.id : null
      ] : []
    }
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.cluster_name}-cluster-sg"
      Type = "EKS-ClusterSecurityGroup"
    }
  )
}

# Security Group para EKS Nodes
resource "aws_security_group" "eks_nodes" {
  name        = "${var.cluster_name}-nodes-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.cluster_name}-nodes-sg"
      Type = "EKS-NodesSecurityGroup"
    }
  )
}

# Regras separadas para evitar dependência circular
resource "aws_security_group_rule" "cluster_ingress_from_nodes" {
  for_each = {
    for rule in var.cluster_security_group_rules.ingress : 
    "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule
    if contains(lookup(rule, "security_groups", []), "eks-nodes")
  }

  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.eks_nodes.id
  security_group_id        = aws_security_group.eks_cluster.id
  description              = each.value.description
}

resource "aws_security_group_rule" "cluster_egress_to_nodes" {
  for_each = {
    for rule in var.cluster_security_group_rules.egress : 
    "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule
    if contains(lookup(rule, "security_groups", []), "eks-nodes")
  }

  type                     = "egress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.eks_nodes.id
  security_group_id        = aws_security_group.eks_cluster.id
  description              = each.value.description
}

resource "aws_security_group_rule" "nodes_ingress_from_cluster" {
  for_each = {
    for rule in var.nodes_security_group_rules.ingress : 
    "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule
    if contains(lookup(rule, "security_groups", []), "eks-cluster")
  }

  type                     = "ingress"
  from_port                = each.value.from_port
  to_port                  = each.value.to_port
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.eks_cluster.id
  security_group_id        = aws_security_group.eks_nodes.id
  description              = each.value.description
}

resource "aws_security_group_rule" "nodes_ingress_self" {
  for_each = {
    for rule in var.nodes_security_group_rules.ingress : 
    "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule
    if lookup(rule, "self", false)
  }

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  self              = true
  security_group_id = aws_security_group.eks_nodes.id
  description       = each.value.description
}

resource "aws_security_group_rule" "nodes_ingress_cidr" {
  for_each = {
    for rule in var.nodes_security_group_rules.ingress : 
    "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule
    if length(lookup(rule, "cidr_blocks", [])) > 0
  }

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.eks_nodes.id
  description       = each.value.description
}

resource "aws_security_group_rule" "nodes_egress" {
  for_each = {
    for rule in var.nodes_security_group_rules.egress : 
    "${rule.from_port}-${rule.to_port}-${rule.protocol}" => rule
  }

  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = lookup(each.value, "cidr_blocks", [])
  security_group_id = aws_security_group.eks_nodes.id
  description       = each.value.description
}

# Security Group adicional para ALB (se necessário)
resource "aws_security_group" "eks_alb" {
  count       = var.create_alb_security_group ? 1 : 0
  name        = "${var.cluster_name}-alb-sg"
  description = "Security group for EKS ALB"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_vpc_id

  # Dynamic block para regras de ingress do ALB
  dynamic "ingress" {
    for_each = var.alb_security_group_rules.ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Dynamic block para regras de egress do ALB
  dynamic "egress" {
    for_each = var.alb_security_group_rules.egress
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = lookup(egress.value, "cidr_blocks", [])
      security_groups = length(lookup(egress.value, "security_groups", [])) > 0 ? [
        for sg_name in egress.value.security_groups : 
          sg_name == "eks-nodes" ? aws_security_group.eks_nodes.id : null
      ] : []
    }
  }

  tags = merge(
    var.common_tags,
    {
      Name = "${var.cluster_name}-alb-sg"
      Type = "EKS-ALBSecurityGroup"
    }
  )
}
