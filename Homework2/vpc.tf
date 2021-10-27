resource "aws_vpc" "Whiskey-VPC" {
  cidr_block = var.cidr_size
  tags = {
    "Name" = "Whiskey-VPC"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}