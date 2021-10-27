resource "aws_nat_gateway" "private-ngw" {
  count = 2
  subnet_id = aws_subnet.private-subnet[count.index].id
  allocation_id = aws_eip.ngw-eip[count.index].id
  tags = {
    "Name" = "private-ngw-${count.index}"
  }
}