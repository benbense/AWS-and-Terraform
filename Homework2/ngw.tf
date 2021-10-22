resource "aws_nat_gateway" "private-ngw-1a" {
  subnet_id = aws_subnet.public1a.id
  allocation_id = aws_eip.ngw-eip-1a.id
  tags = {
    "Name" = "NAT-1a"
  }
}

resource "aws_nat_gateway" "private-ngw-1b" {
  subnet_id = aws_subnet.public1b.id
  allocation_id = aws_eip.ngw-eip-1b.id
  tags = {
    "Name" = "NAT-1b"
  }
}