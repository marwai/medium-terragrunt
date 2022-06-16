terraform {
  source = "${local.base_source_url}//?ref=v3.7.0"
    
  extra_arguments "init_args" {
    commands = ["init"]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract out common variables for reuse
  environment     = local.environment_vars.locals.environment
  region          = local.region_vars.locals.aws_region
  base_source_url = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git//"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------
inputs = {
  name                            = "${local.environment}-${local.region}"
  azs                             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  create_database_subnet_group    = false
  create_elasticache_subnet_group = false
  enable_nat_gateway              = true
  single_nat_gateway              = true
  enable_dns_hostnames            = true
  enable_dns_support              = true
  map_public_ip_on_launch         = false

  tags = {
    Application = "VPC"
  }
}