# ################################################################################################
# ##                                         Listener Rule                                      ##
# ################################################################################################

# resource "aws_lb_listener_rule" "external_forwarder_rule" {
#   listener_arn = var.external_lb_listener_arn
#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.web_server.arn
#   }
#   condition {
#     path_pattern {
#       values = ["/"]
#     }
#   }
#   priority = 1
# }