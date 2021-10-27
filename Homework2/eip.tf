resource "aws_eip" "ngw-eip" {
  count = 2
  tags = {
    "Name" = "NAT-{count.index}"
  }
}