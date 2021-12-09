################################################################################################
##                                         Security Group                                ##
################################################################################################

# Inbound HTTP Port
resource "aws_security_group_rule" "external_port" {
  description       = "Ingress port - 80"
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.security_group.id
  # security_group_id        = 
  to_port                  = 80
  type                     = "ingress"
  source_security_group_id = var.external_lb_security_group_id
}

# resource "aws_security_group_rule" "internal_ui_port" {
#   description       = "Ingress  internal ui port - 80"
#   from_port         = 80
#   protocol          = "tcp"
#   security_group_id = aws_security_group.security_group.id
#   # security_group_id        =
#   to_port                  = 80
#   type                     = "ingress"
#   source_security_group_id = var.internal_lb_security_group_id
# }

# egress all
resource "aws_security_group_rule" "egress_all" {
  description       = "Egress all"
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
}