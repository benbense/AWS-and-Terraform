resource "aws_subnet" "private-subnet" {
  count = 2
  vpc_id = aws_vpc.Whiskey-VPC.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(var.cidr_size, 8, count.index)
  tags = {
    "Name" = "Private-${count.index}"
  }
}

resource "aws_subnet" "public-subnet" {
  count = 2
  vpc_id = aws_vpc.Whiskey-VPC.id
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block = cidrsubnet(var.cidr_size, 8, 100 + count.index)
  tags = {
    "Name" = "Public-${count.index}"
  }
}