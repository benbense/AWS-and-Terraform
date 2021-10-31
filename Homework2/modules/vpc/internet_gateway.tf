resource "aws_internet_gateway" "public-igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "public-igw"
  }
}
