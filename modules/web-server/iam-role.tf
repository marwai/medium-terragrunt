# IAM Role
# resource "aws_iam_role" "iam_role" {
#   name               = "${var.environment}-${var.service}"
#   assume_role_policy = data.aws_iam_policy_document.ec2_role_trust.json
# }