resource "aws_nat_gateway" "private-ngw" {
  count         = length(aws_subnet.private_subnets)
  subnet_id     = aws_subnet.private_subnets[count.index].id
  allocation_id = aws_eip.ngw-eip[count.index].id
  tags = {
    "Name" = "private-ngw-${count.index}"
  }
}
