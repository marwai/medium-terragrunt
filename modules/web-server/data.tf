# ################################################################################################
# ##                                         Data sources                                       ##
# ################################################################################################

# data "aws_iam_account_alias" "current" {
# }

# #########################
# ## 	      EC2          ##
# #########################
# data "aws_iam_policy_document" "ec2_role_trust" {
#   statement {
#     actions = ["sts:AssumeRole"]
#     effect  = "Allow"
#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }
#   }
# }

# #########################
# ##         SSM 	       ##
# #########################

# data "aws_iam_policy_document" "ssm" {
#   statement {
#     actions = [
#       "ssm:UpdateInstanceInformation",
#       "ssmmessages:CreateControlChannel",
#       "ssmmessages:CreateDataChannel",
#       "ssmmessages:OpenControlChannel",
#       "ssmmessages:OpenDataChannel"
#     ]
#     resources = ["*"]
#   }
#   statement {

#     actions = [
#       "s3:GetEncryptionConfiguration"
#     ]
#     resources = ["*"]
#   }
#   statement {
#     actions = [
#       "kms:Decrypt"
#     ]
#     resources = ["*"]
#   }
# }

# data "aws_ami" "ec2" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"]
# }
