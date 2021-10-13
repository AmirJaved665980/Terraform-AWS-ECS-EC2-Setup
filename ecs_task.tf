#### Populating Task definitions from template file with variables 

data "template_file" "task_definitions_template" {
  template = file("templates/task-definitions.json.tpl")

  vars = {
    frontend_image      = "${aws_ecr_repository.ecr_image_frontend.repository_url}"
    backend_image       = "${aws_ecr_repository.ecr_image_backend.repository_url}"
    reverse_proxy_image = "${aws_ecr_repository.ecr_image_reverse_proxy.repository_url}"
    s3_bucket           = "calcx-configs"//${var.s3_bucket_env}/config.env"
    log_group           = "${var.project}-log-group"
    region              = "${var.region}"
    prefix              = "${var.project}"
  }
}

data "aws_ecs_task_definition" "ecs_task_definition" {
  task_definition = "${aws_ecs_task_definition.ecs_task_definition.family}"
  depends_on      = [aws_ecs_task_definition.ecs_task_definition]
}
#####  Task definition 
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                = "${var.project}-task"
  container_definitions = data.template_file.task_definitions_template.rendered
  execution_role_arn    = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn         = aws_iam_role.ecs_iam_role.arn
  cpu                   = 1536
  memory                = 1536
  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-central-1a,eu-central-1b]"
  }
}


resource "aws_security_group" "ecs_tasks" {
  name        = "ecs-tasks-sg"
  vpc_id      = var.vpc_id
  description = "allow inbound access from the ALB only"

  ingress {
    protocol        = "tcp"
    from_port       = var.port
    to_port         = var.port
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.lb-sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}