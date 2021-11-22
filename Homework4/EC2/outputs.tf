output "db_servers_private_ips" {
  description = "Private IP's of the EC2 Databases"
  value       = module.ec2.db_servers_private_ips
}

output "web_servers_public_ips" {
  description = "Public IP's of the EC2 Webservers"
  value       = module.ec2.web_servers_public_ips
}

output "web_servers_private_ips" {
  description = "Private IP's of the EC2 Webservers"
  value       = module.ec2.web_servers_private_ips
}

output "alb_public_dns" {
  description = "ALB Public DNS name"
  value       = module.ec2.alb_public_dns
}
