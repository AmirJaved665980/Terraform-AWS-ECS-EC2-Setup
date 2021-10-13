#
# need an ASG so we can easily add more ecs host nodes as necessary
#
resource "aws_autoscaling_group" "ecs-autoscaling-group" {
  name             = "${var.project}-ecs-autoscaling-group"
  max_size         = "5"
  min_size         = "2"
  desired_capacity = "2"

  vpc_zone_identifier  = [var.subnet_a]
  launch_configuration = "${aws_launch_configuration.ecs-launch-configuration.name}"
  
  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.project}-cluster"
    propagate_at_launch = true
  }
}