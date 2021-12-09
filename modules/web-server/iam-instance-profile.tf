resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.environment}-${var.service}"
  role = aws_iam_role.iam_role.name
}
