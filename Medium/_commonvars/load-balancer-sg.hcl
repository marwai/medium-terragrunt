terraform {
  source = "${local.base_source_url}//?ref=v4.3.0"
}

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  base_source_url  = "git::https://github.com/terraform-aws-modules/terraform-aws-security-group.git//"
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  environment      = local.environment_vars.locals.environment
}


# ---------------------------------------------------------------------------------------------------------------------
# Dependency 
# ---------------------------------------------------------------------------------------------------------------------
dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../../vpc"
}

# ---------------------------------------------------------------------------------------------------------------------
# Inputs
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  vpc_id              = dependency.vpc.outputs.vpc_id
  ingress_cidr_blocks = concat(["/32"])
  ingress_rules       = ["http-80-tcp"]
  name                = "${local.environment}-external"
  description         = "SG to use with external ALB, allow specific traffic internally but limit based on route based rules"
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All egress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}