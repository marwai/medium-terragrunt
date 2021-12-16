# ################################################################################################
# ##                                         Target Group                                       ##
# ################################################################################################
# resource "aws_lb_target_group" "web_server" {
#   health_check {
#     interval            = 20
#     path                = "/"
#     protocol            = "HTTP"
#     timeout             = 10
#     healthy_threshold   = 3
#     unhealthy_threshold = 5
#   }

#   name        = "${var.environment}-http"
#   port        = 80
#   protocol    = "HTTP"
#   vpc_id      = var.vpc_id
#   target_type = "instance"

#   tags = {
#     Name = "${var.environment}-${var.service}-http-target-group"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }