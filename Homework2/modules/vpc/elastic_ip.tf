resource "aws_eip" "ngw-eip" {
  count = length(aws_subnet.private_subnets)
  tags = {
    "Name" = "NAT-{count.index}"
  }
}
