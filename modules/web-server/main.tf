##########################
# Modules
# Data sources
# EC2
# IAM
# Autoscaling Group
# Launch Configuration 
# Listener Rule
# Security Group
# Security Group Rules
# Target group
# Variables
# Outputs 
##########################

####################################################################
##                       Data sources                             ##                      
####################################################################
data "aws_iam_account_alias" "current" {
}
####################################################################
##                           EC2                                  ##                      
####################################################################
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
####################################################################
##                             IAM                                ##                      
####################################################################
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.environment}-${var.service}"
  role = aws_iam_role.iam_role.name
}
# IAM Role
resource "aws_iam_role" "iam_role" {
  name               = "${var.environment}-${var.service}"
  assume_role_policy = data.aws_iam_policy_document.ec2_role_trust.json
}
####################################################################
##                       Autoscaling Group                        ##                      
####################################################################
resource "aws_autoscaling_group" "dev" {
  name                      = "${var.environment}-${var.service}-asg"
  max_size                  = var.max
  min_size                  = var.min
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = "EC2"
  # EC2 instead of ELB, now load balancer only serves when ec2 is healthy
  force_delete         = true
  launch_configuration = aws_launch_configuration.dev.name
  vpc_zone_identifier  = var.private_subnet_ids
  target_group_arns    = [aws_lb_target_group.web_server.arn]
  lifecycle {
    create_before_destroy = true
  }

  tags = [
    {
      "key"                 = "Name"
      "value"               = "${var.environment}-${var.service}-asg"
      "propagate_at_launch" = true
    },
  ]
}
####################################################################
##                        Launch Configuration                    ##                      
####################################################################
resource "aws_launch_configuration" "dev" {
  name_prefix          = "${var.environment}-${var.service}-web-config"
  image_id             = data.aws_ami.ec2.id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.security_group.id]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.id
  enable_monitoring    = true
  user_data = templatefile("${path.module}/lib/web_server.sh.tpl",
    {
      service_name     = var.service
      environment      = var.environment
      aws_account_name = data.aws_iam_account_alias.current.account_alias
  })
  root_block_device {
    encrypted = true
  }
  lifecycle {
    create_before_destroy = true
  }
}
####################################################################
##                             Listener Rule                      ##         
####################################################################
resource "aws_lb_listener_rule" "external_forwarder_rule" {
  listener_arn = var.external_lb_listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_server.arn
  }
  condition {
    path_pattern {
      values = ["/"]
    }
  }
  priority = 1
}

####################################################################
##                                Security Group                  ##
####################################################################

resource "aws_security_group" "security_group" {
  name   = "${var.environment}-${var.service}-instance-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.environment}-web-security-group"
  }
}

####################################################################
##                          Security Group Rules                  ##            
####################################################################
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
####################################################################
##                          Target Group                          ##            
####################################################################
resource "aws_lb_target_group" "web_server" {
  health_check {
    interval            = 20
    path                = "/"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 5
  }

  name        = "${var.environment}-http"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  tags = {
    Name = "${var.environment}-${var.service}-http-target-group"
  }

  lifecycle {
    create_before_destroy = true
  }
}

####################################################################
##                             Variables                          ##
####################################################################

variable "environment" {
  default     = "tools"
  type        = string
  description = "Environment name"
}

variable "service" {
  default     = "web-server"
  type        = string
  description = "Service name"
}

variable "instance_type" {
  default     = "t2.micro"
  type        = string
  description = "type of instance"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "ID of the private subnet"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "ID of the subnet subnet"
}

variable "max" {
  default     = 6
  type        = number
  description = "Maximum number of autoscaling group instances"
}

variable "min" {
  default     = 3
  type        = number
  description = "Minimum number of autoscaling groups instances"
}

variable "desired_capacity" {
  default     = 3
  type        = number
  description = "Desired number of Autoscaling Groups"
}

variable "log_expire_days" {
  default     = 7
  type        = number
  description = "value"
}

variable "kms_arn" {
  default     = "*"
  type        = string
  description = "ARN of KMS key used by cloudwatch used in session manager"
}


variable "available_zones" {
  type = list(string)
}

variable "acm_wildcard_arn" {
  type        = string
  description = ""
  default     = ""
}

variable "public_zone_id" {
  type        = string
  description = ""
  default     = ""
}

variable "company_name" {
  default     = "Change this to the client"
  type        = string
  description = "Name of the company"
}

variable "lb_ingress_rules" {
  default     = ["null"]
  type        = list(string)
  description = "allowed ips to web-server"
}

variable "create_load_balancer" {
  default     = true
  type        = bool
  description = "whether to create resource"
}

variable "external_target_group_arns" {
  type    = list(string)
  default = []
}

variable "project_name" {
  type    = string
  default = "Medium"
}

variable "external_lb_listener_arn" {
  type        = string
  default     = ""
  description = "Listener arn for the external load balancer"
}

variable "external_lb_name" {
  type        = string
  description = "Name of external load balancer"
  default     = "medium-lb"
}

variable "external_lb_zone_id" {
  type        = string
  description = "Zone ID of external load balancer"
}

variable "external_lb_security_group_id" {
  type        = string
  description = "Security group of external load balancer"
}

####################################################################
##                          Output                                ##                                        
####################################################################
output "asg_arn" {
  value = aws_autoscaling_group.dev.arn
}