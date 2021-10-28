resource "aws_elb" "web-elb" {
  name = "web-elb"
  instances = aws_instance.webservers.*.id
  security_groups = [aws_security_group.inbound-http-any.id, aws_security_group.outbound-any.id]
  subnets = aws_subnet.public-subnet.*.id

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 10
  }
  tags = {
    "Name" = "web-elb"
  }
}