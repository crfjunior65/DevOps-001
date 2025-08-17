# EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = data.terraform_remote_state.vpc.outputs.vpc_private_subnets_id
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = [aws_security_group.eks_cluster.id]
  }

  # Configuração de logging
  enabled_cluster_log_types = var.cluster_log_types

  # Dynamic block para configurações de encryption
  dynamic "encryption_config" {
    for_each = var.encryption_config
    content {
      provider {
        key_arn = encryption_config.value.kms_key_arn
      }
      resources = encryption_config.value.resources
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller,
  ]

  tags = merge(
    var.common_tags,
    {
      Name = var.cluster_name
      Type = "EKS-Cluster"
    }
  )
}

# EKS Node Groups
resource "aws_eks_node_group" "main" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = data.terraform_remote_state.vpc.outputs.vpc_private_subnets_id

  # Configuração de instâncias
  instance_types = each.value.instance_types
  ami_type       = each.value.ami_type
  capacity_type  = each.value.capacity_type
  disk_size      = each.value.disk_size

  # Configuração de scaling
  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  # Configuração de update
  update_config {
    max_unavailable_percentage = each.value.max_unavailable_percentage
  }

  # Dynamic block para configurações de launch template
  dynamic "launch_template" {
    for_each = each.value.launch_template != null ? [each.value.launch_template] : []
    content {
      id      = launch_template.value.id
      version = launch_template.value.version
    }
  }

  # Dynamic block para configurações de remote access
  dynamic "remote_access" {
    for_each = each.value.remote_access != null ? [each.value.remote_access] : []
    content {
      ec2_ssh_key               = remote_access.value.ec2_ssh_key
      source_security_group_ids = remote_access.value.source_security_group_ids
    }
  }

  # Dynamic block para taints
  dynamic "taint" {
    for_each = each.value.taints != null ? each.value.taints : []
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_container_registry_policy,
  ]

  tags = merge(
    var.common_tags,
    each.value.tags,
    {
      Name = "${var.cluster_name}-${each.key}"
      Type = "EKS-NodeGroup"
    }
  )
}

# EKS Addons
resource "aws_eks_addon" "main" {
  for_each = var.cluster_addons

  cluster_name             = aws_eks_cluster.main.name
  addon_name               = each.key
  addon_version            = each.value.version
  resolve_conflicts        = each.value.resolve_conflicts
  service_account_role_arn = each.value.service_account_role_arn

  depends_on = [
    aws_eks_node_group.main
  ]

  tags = merge(
    var.common_tags,
    {
      Name = "${var.cluster_name}-${each.key}"
      Type = "EKS-Addon"
    }
  )
}
