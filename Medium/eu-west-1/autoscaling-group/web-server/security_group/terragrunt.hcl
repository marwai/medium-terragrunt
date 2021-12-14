include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git//?ref=v4.7.0"

  extra_arguments "init_args" {
    commands = [
      "init"
    ]

    arguments = [
    ]
  }

}

dependency "vpc" {
  config_path = "../../../infrastructure//vpc"
}

dependency "external-security-group" {
  config_path = "../../../infrastructure/load-balancer//external-security-group"
}


inputs = {
  name        = "front-end-security-group-asg"
  description = "Instance SG to allow LB"
  vpc_id      = dependency.vpc.outputs.vpc_id

  # Ingress Rules
  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "allow lb ingress"
      source_security_group_id = dependency.external-security-group.outputs.security_group_id
    }
  ]

  # Egress Rules
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All egress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name        = "frontend-security-group"
    Owner       = "Marcus"
    Contact     = "marcus.tse"
    Project     = "Terragrunt Medium"
    Environment = "Development"
  }
}

