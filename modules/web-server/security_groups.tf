resource "aws_security_group" "security_group" {
  name   = "${var.environment}-${var.service}-instance-sg"
  vpc_id = var.vpc_id
}
