resource "aws_eip" "ngw-eip-1a" {
  tags = {
    "Name" = "NAT-1a-EIP"
  }
}
resource "aws_eip" "ngw-eip-1b" {
  tags = {
    "Name" = "NAT-1b-EIP"
  }
}