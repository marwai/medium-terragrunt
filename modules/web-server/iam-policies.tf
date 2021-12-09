resource "aws_iam_policy" "bucket_policy" {
  name   = "${var.company_name}-${var.environment}-${var.service}-policy"
  policy = data.aws_iam_policy_document.bucket_policy.json
}

resource "aws_iam_policy" "kms_policy" {
  name   = "${var.environment}-${var.service}-kms-policy"
  policy = data.aws_iam_policy_document.kms_policy_document.json
}

resource "aws_iam_policy" "ssm_policy" {
  name   = "${var.environment}-${var.service}-ssm-policy"
  policy = data.aws_iam_policy_document.ssm.json

}