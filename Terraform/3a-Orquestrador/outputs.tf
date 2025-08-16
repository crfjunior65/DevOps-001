output "bastion_key_name" {
  description = "The key name associated with the bastion host."
  value       = aws_key_pair.deployer.key_name
}

output "bastion_sg_ids" {
  description = "The security group IDs associated with the bastion host."
  value       = aws_instance.ec2_bastianhost.vpc_security_group_ids
}

output "bastion_public_ip" {
  description = "The public IP address of the bastion host."
  value       = aws_instance.ec2_bastianhost.public_ip
}

output "bastion_private_ip" {
  description = "The private IP address of the bastion host."
  value       = aws_instance.ec2_bastianhost.private_ip
}

output "bastion_instance_id" {
  description = "The instance ID of the bastion host."
  value       = aws_instance.ec2_bastianhost.id
}
