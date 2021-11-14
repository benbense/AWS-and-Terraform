output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "available_zone_names" {
  value = data.aws_availability_zones.available.names
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnets.*.id
}

output "private_subnets_ids" {
  value = aws_subnet.private_subnets.*.id
}
