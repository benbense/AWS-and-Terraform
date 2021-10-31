resource "aws_instance" "databases" {
  count                  = var.instances_to_create
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = var.available_zone_names[count.index]
  subnet_id              = var.private_subnets_ids[count.index]
  vpc_security_group_ids = [aws_security_group.inbound_ssh_any.id, aws_security_group.outbound_any.id]
  key_name               = var.key_name
  tags = {
    "Name" = "DB-${count.index}"
  }
}
