data "aws_iam_account_alias" "current" {
}

#########################
## 	       KMS 	       ##
#########################
data "aws_iam_policy_document" "kms_policy_document" {
  statement {
    actions = ["kms:Decrypt"]
    resources = [
      var.kms_arn
    ]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }
}

#########################
## 	      EC2          ##
#########################
data "aws_iam_policy_document" "ec2_role_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

#########################
##         SSM 	       ##
#########################

data "aws_iam_policy_document" "ssm" {
  statement {
    actions = [
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
    resources = ["*"]
  }
  statement {

    actions = [
      "s3:GetEncryptionConfiguration"
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "kms:Decrypt"
    ]
    resources = ["*"]
  }
}

#########################
##     Bucket    ##
#########################

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListAllMyBuckets",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
      "s3:PutObjectTagging",
      "s3:GetObjectTagging",
      "s3:DeleteObjectTagging",
      "s3:GetLifecycleConfiguration",
      "s3:GetBucketAcl",
      "s3:PutLifecycleConfiguration"
    ]
    effect    = "Allow"
    resources = [aws_s3_bucket.log_bucket.arn, "${aws_s3_bucket.log_bucket.arn}/*"]
  }
}

data "aws_ami" "ec2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
