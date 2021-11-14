output "db_servers_private_ips" {
  value = aws_instance.databases.*.private_ip
}

output "web_servers_public_ips" {
  value = aws_instance.webservers.*.public_ip
}

output "alb_public_dns" {
  value = aws_alb.webservers.dns_name
}
