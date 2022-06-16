
terraform {
  source = "${local.base_source_url}//?ref=v6.6.1"
}

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  base_source_url = "git::https://github.com/terraform-aws-modules/terraform-aws-alb.git//"
  # Extract out common variables for reuse
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  environment      = local.environment_vars.locals.environment
}

# ---------------------------------------------------------------------------------------------------------------------
# Dependency 
# ---------------------------------------------------------------------------------------------------------------------
dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../../vpc"
}

dependency "external-security-group" {
  config_path = "${get_terragrunt_dir()}/../external-security-group/"
}



# ---------------------------------------------------------------------------------------------------------------------
# Inputs
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  vpc_id          = dependency.vpc.outputs.vpc_id
  subnets         = dependency.vpc.outputs.public_subnets
  security_groups = [dependency.external-security-group.outputs.security_group_id]

  name               = "${local.environment}-external"
  load_balancer_type = "application"
  internal           = false
  target_groups = [
    {
      name             = "${local.environment}-to-nothing"
      backend_protocol = "HTTP"
      backend_port     = 80
    }
  ]

  http_tcp_listeners = [
    {
      port               = "80"
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}