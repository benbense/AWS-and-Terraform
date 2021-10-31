resource "aws_subnet" "private_subnets" {
  count             = var.availability_zones
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.zone_ids[count.index]
  cidr_block        = cidrsubnet(var.cidr_size, 8, count.index)
  tags = {
    "Name" = "Private-${count.index}"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = var.availability_zones
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.zone_ids[count.index]
  cidr_block              = cidrsubnet(var.cidr_size, 8, 100 + count.index)
  tags = {
    "Name" = "Public-${count.index}"
  }
}
