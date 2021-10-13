#
# need to add security group config
# so that we can ssh into an ecs host from bastion box
#
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
  owners = ["amazon"]
}

resource "aws_launch_configuration" "ecs-launch-configuration" {
  name                 = "${var.project}-ecs-launch-configuration"
  image_id             = data.aws_ami.amazon_linux.id
  instance_type        = "t2.medium"
  iam_instance_profile = "${aws_iam_instance_profile.ecs-instance-profile-d.id}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 100
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
  security_groups = [aws_security_group.lb-sg.id]
  associate_public_ip_address = "true"
  key_name                    = var.key_name

  #
  # register the cluster name with ecs-agent which will in turn coord
  # with the AWS api about the cluster
  #
  user_data = <<EOF
                #!/bin/bash
                echo ECS_CLUSTER=${var.project}-cluster >> /etc/ecs/ecs.config
                EOF
}
