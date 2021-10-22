resource "aws_instance" "webserver-1a" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.t2-micro
  availability_zone = "us-east-1a"
  subnet_id = aws_subnet.public1a.id
  vpc_security_group_ids = [aws_security_group.inbound-http-any.id, aws_security_group.inbound-ssh-any.id, aws_security_group.outbound-any.id]
  key_name = var.key_name
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo chmod 777 /var/www/html/index.nginx-debian.html",
      "sudo echo \"Welcome to Grandpa's Whiskey\" > /var/www/html/index.nginx-debian.html",
      "sudo service nginx start"
    ]
  }
  tags = {
    "Name" = "Webserver-1"
  }
}

resource "aws_instance" "webserver-1b" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.t2-micro
  availability_zone = "us-east-1b"
  subnet_id = aws_subnet.public1b.id
  vpc_security_group_ids = [aws_security_group.inbound-http-any.id, aws_security_group.inbound-ssh-any.id, aws_security_group.outbound-any.id]
  key_name = var.key_name
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo chmod 777 /var/www/html/index.nginx-debian.html",
      "sudo echo \"Welcome to Grandpa's Whiskey\" > /var/www/html/index.nginx-debian.html",
      "sudo service nginx start"
    ]
  }
  tags = {
    "Name" = "Webserver-2"
  }
}
