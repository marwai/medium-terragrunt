# ################################################################################################
# ##                                         Launch Configuration                               ##
# ################################################################################################

# # Launch Configuration
# resource "aws_launch_configuration" "dev" {
#   name_prefix          = "${var.environment}-${var.service}-web-config"
#   image_id             = data.aws_ami.ec2.id
#   instance_type        = var.instance_type
#   security_groups      = [aws_security_group.security_group.id]
#   iam_instance_profile = aws_iam_instance_profile.instance_profile.id
#   enable_monitoring    = true
#   user_data = templatefile("${path.module}/lib/web_server.sh.tpl",
#     {
#       service_name     = var.service
#       environment      = var.environment
#       aws_account_name = data.aws_iam_account_alias.current.account_alias
#   })
#   root_block_device {
#     encrypted = true
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }

