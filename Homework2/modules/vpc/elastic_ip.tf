resource "aws_eip" "ngw-eip" {
  count = length(aws_subnet.private-subnet)
  tags = {
    "Name" = "NAT-{count.index}"
  }
}