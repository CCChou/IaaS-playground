output "security_group_id" {
  description = "ID of the security group attached to the EC2 instances"
  value       = aws_security_group.ec2_instance_sg.id
}

output "public_dns" {
  description = "Public DNS names of the EC2 instances"
  value       = aws_instance.ec2_instance[*].public_dns
}
