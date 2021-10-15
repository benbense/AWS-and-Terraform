# Variables
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  default = "us-east-1"
}
variable "availability_zone" {
  default = "us-east-1a"
}
variable "instances_to_create" {
  default = 2
}

# Provider
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

# Data
data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64*"]
    }
}

# Resources

# Default VPC
resource "aws_default_vpc" "default" {

}

# Enable TCP access to port 80
resource "aws_security_group" "allow_http_access" {
  name = "allow_http_access"
  vpc_id = aws_default_vpc.default.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
    
  }
}

# Enable SSH access to port 22
resource "aws_security_group" "allow_ssh_access" {
  name = "allow_ssh_access"
  vpc_id = aws_default_vpc.default.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
}

# Enable instance access to the world
resource "aws_security_group" "allow_outbound_any" {
  name = "allow_outbound_any"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instances
resource "aws_instance" "webserver" {
  count = var.instances_to_create
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = var.key_name
  availability_zone = var.availability_zone
  vpc_security_group_ids = [aws_security_group.allow_http_access.id, aws_security_group.allow_ssh_access.id, aws_security_group.allow_outbound_any.id]
  
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file(var.private_key_path)
  }

  # Install Nginx and modify the homepage
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
    Name = "Gandpa_${count.index}"
    Owner = "Ben"
    Purpose = "whiskey"
    Department = "dev"
  }

}

# Create encrypted EBS volume
resource "aws_ebs_volume" "create_vol" {
  count = var.instances_to_create
  availability_zone = var.availability_zone
  size = 10
  encrypted = true
  type = "gp2" # Although gp2 is default
}

# Assign each volume to an EC2 instance
resource "aws_volume_attachment" "attach_vol" {
  count = var.instances_to_create
  device_name = "/dev/sdh"
  volume_id = "${element(aws_ebs_volume.create_vol.*.id, count.index)}"
  instance_id = "${element(aws_instance.webserver.*.id, count.index)}"
  }

# Get the public DNS of the instance 
output "aws_instance_public_dns" {
  value = aws_instance.webserver.*.public_dns
}