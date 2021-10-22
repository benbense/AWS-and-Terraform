
# Enable TCP access to port 80
resource "aws_security_group" "inbound-http-any" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  tags = {
    "Name" = "inbound-http-any"
  }
}

# Enable SSH access to port 22
resource "aws_security_group" "inbound-ssh-any" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  tags = {
    "Name" = "inbound-ssh-any"
  }
}

# Enable instance access to the world
resource "aws_security_group" "outbound-any" {
  vpc_id = aws_vpc.Whiskey-VPC.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "outbound-any"
  }
}