resource "aws_route_table" "public_web" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "public_web"
  }
}

resource "aws_route_table" "private_rt" {
  count  = length(aws_subnet.private_subnets)
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "private_rt-${count.index}"
  }
}


resource "aws_route" "all_gateway" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public_web.id
  gateway_id             = aws_internet_gateway.public-igw.id
}

resource "aws_route" "private_routes" {
  count                  = length(aws_route_table.private_rt)
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private_rt[count.index].id
  gateway_id             = aws_nat_gateway.private-ngw[count.index].id
}

resource "aws_route_table_association" "private_rt_assign" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}

resource "aws_route_table_association" "public_rt_assign" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_web.id
}
