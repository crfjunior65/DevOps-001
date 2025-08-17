# Outputs dos Addons
output "cluster_addons" {
  description = "Status dos addons do cluster"
  value = {
    for k, v in aws_eks_addon.main : k => {
      arn            = v.arn
      addon_version  = v.addon_version
    }
  }
}
