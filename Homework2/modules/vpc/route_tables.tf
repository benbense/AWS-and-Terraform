resource "aws_route_table" "public-web" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "Public-Web"
  }
}

resource "aws_route_table" "private-rt" {
  count = length(aws_subnet.private-subnet)
  vpc_id = aws_vpc.vpc.id
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
  count = length(aws_route_table.private-rt)
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.private-rt[count.index].id
  gateway_id = aws_nat_gateway.private-ngw[count.index].id
}

resource "aws_route_table_association" "private-rt-assign" {
  count = length(aws_subnet.private-subnet)
  subnet_id = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private-rt[count.index].id
} 

resource "aws_route_table_association" "public-rt-assign" {
  count = length(aws_subnet.private-subnet)
  subnet_id = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-web.id
}