
# Enable TCP access to port 80
resource "aws_security_group" "inbound_http_any" {
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }
  tags = {
    "Name" = "inbound_http_any"
  }
}

# Enable SSH access to port 22
resource "aws_security_group" "inbound_ssh_any" {
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  tags = {
    "Name" = "inbound_ssh_any"
  }
}

# Enable instance access to the world
resource "aws_security_group" "outbound_any" {
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "outbound_any"
  }
}
