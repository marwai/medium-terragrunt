# include {
#   path = find_in_parent_folders()
# }

# terraform {
#   source = "git::https://github.com/terraform-aws-modules/terraform-aws-autoscaling.git//?ref=v4.9.0"

#   extra_arguments "init_args" {
#     commands = [
#       "init"
#     ]


#     arguments = [
#     ]
#   }
# }

# dependency "vpc" {
#   config_path = "../../../infrastructure/vpc"
# }

# dependency "web-server-security" {
#   config_path = "../security_group"
# }

# dependency "external-alb" {
#   config_path = "../../../infrastructure/load-balancer/external-alb"
# }

# dependency "external-security-group" {
#   config_path = "../../../infrastructure/load-balancer/external-security-group"
# }

# dependency "ami" {
#   config_path = "../ami"
# }

# inputs = {
#   # Launch configuration
#   name      = "web-server-asg-terragrunt"
#   lc_name   = "example-lc"
#   create_lc = true
#   use_lc    = true


#   image_id = dependency.ami.outputs.aws_ami
#   # image_id        = "ami-ebd02392"
#   instance_type   = "t2.micro"
#   security_groups = [dependency.web-server-security.outputs.security_group_id]

#   user_data = "./web_server.sh.tpl"
#   # ebs_block_device = [
#   #   {
#   #     device_name           = "/dev/sda1"
#   #     volume_type           = "gp2"
#   #     volume_size           = "8"
#   #     delete_on_termination = true
#   #   },
#   # ]

#   root_block_device = [
#     {
#       volume_size = "8"
#       volume_type = "gp2"
#       encrypted   = true
#     },
#   ]

#   # Auto scaling group
#   asg_name                  = "example-asg"
#   vpc_zone_identifier       = dependency.vpc.outputs.private_subnets
#   health_check_type         = "EC2"
#   min_size                  = 3
#   max_size                  = 6
#   desired_capacity          = 3
#   wait_for_capacity_timeout = 0
#   iam_instance_profile_name = "webserver-env-web-server-ami"
#   iam_instance_profile_arn  = "arn:aws:iam::323040907683:instance-profile/webserver-env-web-server-ami"
#   target_group_arns         = dependency.external-alb.outputs.target_group_arns

#   tags = [
#     {
#       key                 = "Service"
#       value               = "external-alb"
#       propagate_at_launch = true
#     },
#     {
#       key                 = "Owner"
#       value               = "Marcus"
#       propagate_at_launch = true
#     },
#     {
#       key                 = "Contact"
#       value               = "Marcus.Tse"
#       propagate_at_launch = true
#     },
#     {
#       key                 = "Project"
#       value               = "Terragrunt Medium"
#       propagate_at_launch = true
#     },
#     {
#       key                 = "Environment"
#       value               = "Development"
#       propagate_at_launch = true
#     }
#   ]

# }