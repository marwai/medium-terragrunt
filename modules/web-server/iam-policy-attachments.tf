# AWS Systems Manager
resource "aws_iam_role_policy_attachment" "ssm_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}

# Web_server
resource "aws_iam_policy_attachment" "ec2_attachment" {
  name       = "${var.environment}-${var.service}"
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = aws_iam_policy.bucket_policy.arn
}

# AWS Key Management Service
resource "aws_iam_policy_attachment" "kms_policy_attachment" {
  name       = "${var.environment}-${var.service}-kms-policy-attachment"
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = aws_iam_policy.kms_policy.arn
}