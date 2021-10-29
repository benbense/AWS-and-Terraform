resource "aws_instance" "webservers" {
  count = 2
  ami = data.aws_ami.ubuntu.id
  instance_type = var.t2-micro
  availability_zone = data.aws_availability_zones.available.names[count.index]
  subnet_id = aws_subnet.public-subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.inbound-http-any.id, aws_security_group.inbound-ssh-any.id, aws_security_group.outbound-any.id]
  key_name = var.key_name
  user_data = local.webservers-instance-userdata
  
  tags = {
    "Name" = "webserver-${count.index}"
  }
}