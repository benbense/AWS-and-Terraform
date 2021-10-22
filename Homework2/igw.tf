resource "aws_internet_gateway" "public-igw" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  tags = {
    "Name" = "public-igw"
  }
}
