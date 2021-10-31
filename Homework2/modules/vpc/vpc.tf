resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_size
  tags = {
    "Name" = "${var.vpc_name}"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

