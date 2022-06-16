
terraform {
  source = "${local.base_source_url}//?ref=feature/web-server"
}

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  base_source_url  = "git::https://github.com/marwai/web-server-example.git//"
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  environment      = local.environment_vars.locals.environment
  region           = local.region_vars.locals.aws_region
}

# ---------------------------------------------------------------------------------------------------------------------
# Dependency 
# ---------------------------------------------------------------------------------------------------------------------
dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../../infrastructure/vpc"
}

dependency "external_alb" {
  config_path = "${get_terragrunt_dir()}/../../infrastructure/load-balancer/external-alb/"
}

dependency "external_security_group" {
  config_path = "${get_terragrunt_dir()}/../../infrastructure/load-balancer/external-security-group"
}


# ---------------------------------------------------------------------------------------------------------------------
# Inputs
# ---------------------------------------------------------------------------------------------------------------------
inputs = {

  # VPC
  available_zones    = dependency.vpc.outputs.azs
  vpc_id             = dependency.vpc.outputs.vpc_id
  private_subnet_ids = dependency.vpc.outputs.private_subnets
  public_subnet_ids  = dependency.vpc.outputs.public_subnets
  region             = "${local.region}"

  # Set Inputs
  company_name     = ""
  lb_ingress_rules = ["/32"]
  project_name     = "Terragrunt Medium"

  # listener configuration 
  external_lb_security_group_id = dependency.external_security_group.outputs.security_group_id
  external_lb_listener_arn      = dependency.external_alb.outputs.http_tcp_listener_arns[0]
  external_lb_name              = dependency.external_alb.outputs.lb_dns_name
  external_lb_zone_id           = dependency.external_alb.outputs.lb_zone_id
  external_target_group_arns    = dependency.external_alb.outputs.target_group_arns
  environment                   = "${local.environment}"
}