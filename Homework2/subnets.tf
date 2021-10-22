
resource "aws_subnet" "private1a" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/24"
  tags = {
    "Name" = "private-1a"
  }
}
resource "aws_subnet" "private1b" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.2.0/24"
  tags = {
    "Name" = "private-1b"
  }
}

resource "aws_subnet" "public1a" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  cidr_block = "10.0.10.0/24"
  tags = {
    "Name" = "public-1a"
  }
}
resource "aws_subnet" "public1b" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  cidr_block = "10.0.11.0/24"
  tags = {
    "Name" = "public-1b"
  }
}
