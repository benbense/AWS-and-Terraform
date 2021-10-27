resource "aws_route_table" "public-web" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  tags = {
    "Name" = "Public-Web"
  }
}

resource "aws_route_table" "private-rt" {
  count = 2
  vpc_id = aws_vpc.Whiskey-VPC.id
  tags = {
    "Name" = "Private-rt-${count.index}"
  }
}


resource "aws_route" "all-gateway" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.public-web.id
  gateway_id = aws_internet_gateway.public-igw.id
}

resource "aws_route" "private-routes" {
  count = 2
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.private-rt[count.index].id
  gateway_id = aws_nat_gateway.private-ngw[count.index].id
}

resource "aws_route_table_association" "private-asso" {
  count = 2
  subnet_id = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-rt[count.index].id
} 
resource "aws_route_table_association" "public-web-1a" {
  subnet_id = aws_subnet.public1a.id
  route_table_id = aws_route_table.public-web.id
}

resource "aws_route_table_association" "public-web-1b" {
  subnet_id = aws_subnet.public1b.id
  route_table_id = aws_route_table.public-web.id
}
