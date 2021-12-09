# Autoscaling Group
resource "aws_autoscaling_group" "dev" {
  name                      = "${var.environment}-${var.service}-asg"
  max_size                  = var.max
  min_size                  = var.min
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "EC2"

  # EC2 instead of ELB, now load balancer only serves when ec2 is healthy
  force_delete         = true
  launch_configuration = aws_launch_configuration.dev.name
  vpc_zone_identifier  = var.private_subnet_ids
  target_group_arns    = [aws_lb_target_group.web_server.arn]
  lifecycle {
    create_before_destroy = true
  }
}