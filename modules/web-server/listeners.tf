
resource "aws_lb_listener_rule" "external_forwarder_rule" {
  listener_arn = var.external_lb_listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_server.arn
    # target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:323040907683:targetgroup/external-route-to-nothing/a94ff4eacf331580"
  }
  condition {
    path_pattern {
      values = ["/"]
    }
  }
}