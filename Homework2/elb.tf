resource "aws_alb" "webservers" {
  name = "web-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.inbound-http-any.id, aws_security_group.outbound-any.id]
  subnets = aws_subnet.public-subnet.*.id
  access_logs {
    bucket = data.aws_s3_bucket.main_bucket.bucket
    prefix = "logs/webservers-alb"
    enabled = true
  }
}

resource "aws_alb_listener" "webservers" {
  load_balancer_arn = aws_alb.webservers.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.webservers.arn
  }
}
resource "aws_alb_target_group" "webservers" {
  name = "alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.Whiskey-VPC.id
  stickiness {
    type = "lb_cookie"
    cookie_duration = 60
    enabled = true
  }
  health_check {
    port = 80
    protocol = "HTTP"
    path = "/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 10
  }
}

resource "aws_alb_target_group_attachment" "webservers" {
  count = length(aws_instance.webservers)
  target_group_arn = aws_alb_target_group.webservers.arn
  target_id = aws_instance.webservers.*.id[count.index]
  port = 80
  }