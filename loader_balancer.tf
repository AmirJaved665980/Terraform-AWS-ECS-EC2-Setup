#### Application Load balancer 
resource "aws_elb" "lb" {
  name            = var.project
  security_groups = [aws_security_group.lb-sg.id]
  subnets         = [var.subnet_a, var.subnet_b]
 
  listener {
    lb_protocol = "http"
    lb_port     = 80

    instance_protocol = "http"
    instance_port     = 80
  }
  
  health_check {
    target = "HTTP:80/api/v1/info"
    healthy_threshold = 5
    unhealthy_threshold = 5
    timeout = 45
    interval = 60
  }
  cross_zone_load_balancing = true
}



#### Security group rules for Load balancer 
resource "aws_security_group" "lb-sg" {
  name        = "${var.project}-lb-sg"
  vpc_id      = var.vpc_id
  description = "controls access to the Application Load Balancer (ALB)"

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}