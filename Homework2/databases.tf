resource "aws_instance" "db-1a" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.t2-micro
  availability_zone = "us-east-1a"
  subnet_id = aws_subnet.private1a.id
  vpc_security_group_ids = [aws_security_group.inbound-ssh-any.id, aws_security_group.outbound-any.id]
  key_name = var.key_name
  tags = {
    "Name" = "DB-1"
  }
}

resource "aws_instance" "db-1b" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.t2-micro
  availability_zone = "us-east-1b"
  subnet_id = aws_subnet.private1b.id
  vpc_security_group_ids = [aws_security_group.inbound-ssh-any.id, aws_security_group.outbound-any.id]
  key_name = var.key_name
  tags = {
    "Name" = "DB-2"
  }
}