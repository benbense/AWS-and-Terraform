resource "aws_route_table" "public-web" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  tags = {
    "Name" = "Public-Web"
  }
}

resource "aws_route_table" "private-1a" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  tags = {
    "Name" = "private-1a"
  }
}

resource "aws_route_table" "private-1b" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  tags = {
  "Name" = "private-1b"
  }
}

resource "aws_route" "all-gateway" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.public-web.id
  gateway_id = aws_internet_gateway.public-igw.id
}

resource "aws_route" "private-1a-nat" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.private-1a.id
  gateway_id = aws_nat_gateway.private-ngw-1a.id
}

resource "aws_route" "private-1b-nat" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.private-1b.id
  gateway_id = aws_nat_gateway.private-ngw-1b.id
}

resource "aws_route_table_association" "public-web-1a" {
  subnet_id = aws_subnet.public1a.id
  route_table_id = aws_route_table.public-web.id
}

resource "aws_route_table_association" "public-web-1b" {
  subnet_id = aws_subnet.public1b.id
  route_table_id = aws_route_table.public-web.id
}

resource "aws_route_table_association" "private-1a" {
  subnet_id = aws_subnet.private1a.id
  route_table_id = aws_route_table.private-1a.id
}

resource "aws_route_table_association" "private-1b" {
  subnet_id = aws_subnet.private1b.id
  route_table_id = aws_route_table.private-1b.id
}