output "vpc_workspace_id" {
  description = "VPC Workspace ID"
  value       = tfe_workspace.vpc.id
}

output "ec2c_workspace_id" {
  description = "EC2 Workspace ID"
  value       = tfe_workspace.ec2.id
}
