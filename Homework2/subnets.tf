resource "aws_subnet" "private-subnet" {
  count = 2
  vpc_id = aws_vpc.Whiskey-VPC.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(var.cidr_size, 8, count.index)
  tags = {
    "Name" = "Private-${count.index}"
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
