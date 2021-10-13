#### ECS Service #####
resource "aws_ecs_service" "ecs-service" {
  name            = "${var.project}-service"
  cluster         = "${aws_ecs_cluster.ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.family}:${max("${aws_ecs_task_definition.ecs_task_definition.revision}", "${data.aws_ecs_task_definition.ecs_task_definition.revision}")}"
  desired_count   = 2

  iam_role = "${aws_iam_role.ecs-service-role.name}"

  load_balancer {
    elb_name       = "${aws_elb.lb.id}"
    container_name = "reverse-proxy"
    container_port = var.port
  }
 // depends_on = [aws_alb_target_group.lb-target]
}



resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "${var.project}-log-group"

  tags = {
    Environment = "staging"
    Application = "${var.project}-application"
  }
}

