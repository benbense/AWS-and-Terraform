# EC2 Instances
resource "aws_instance" "webservers" {
  count                  = var.instances_to_create
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = var.available_zone_names[count.index]
  subnet_id              = var.public_subnets_ids[count.index]
  vpc_security_group_ids = [aws_security_group.inbound_http_any.id, aws_security_group.inbound_ssh_any.id, aws_security_group.outbound_any.id]
  key_name               = var.key_name
  user_data              = local.webservers-instance-userdata

  tags = {
    "Name" = "webserver-${count.index}"
  }
}
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


# Application Load Balancer
resource "aws_alb" "webservers" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.inbound_http_any.id, aws_security_group.outbound_any.id]
  subnets            = var.public_subnets_ids
  access_logs {
    bucket  = data.aws_s3_bucket.main_bucket.bucket
    prefix  = "logs/webservers-alb"
    enabled = true
  }
}

resource "aws_alb_listener" "webservers" {
  load_balancer_arn = aws_alb.webservers.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.webservers.arn
  }
}
resource "aws_alb_target_group" "webservers" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 60
    enabled         = true
  }
  health_check {
    port                = 80
    protocol            = "HTTP"
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 10
  }
}

resource "aws_alb_target_group_attachment" "webservers" {
  count            = length(aws_instance.webservers)
  target_group_arn = aws_alb_target_group.webservers.arn
  target_id        = aws_instance.webservers.*.id[count.index]
  port             = 80
}



# Data
data "aws_s3_bucket" "main_bucket" {
  bucket = var.bucket_name
}


# Security Groups

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

# User Data
locals {
  webservers-instance-userdata = <<USERDATA
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sed -i "s/nginx/Grandpa's Whiskey $HOSTNAME/g" /var/www/html/index.nginx-debian.html
sed -i '15,23d' /var/www/html/index.nginx-debian.html
service nginx restart
USERDATA
}

