resource "aws_vpc" "Whiskey-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "Whiskey-VPC"
  }
}