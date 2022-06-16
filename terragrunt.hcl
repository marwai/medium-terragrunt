# ---------------------------------------------------------------------------------------------------------------------
# Remote State 
# ---------------------------------------------------------------------------------------------------------------------
remote_state {
  backend = "s3"
  config = {
    # Change this to a globally unique name
    bucket  = "medium-terragrunt-example"
    key     = "terragrunt/${path_relative_to_include()}.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}

terraform {
  extra_arguments "common_vars" {
    commands           = get_terraform_commands_that_need_vars()
    optional_var_files = []
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# One Providers block to rule them all
# ---------------------------------------------------------------------------------------------------------------------
generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  default_tags {
  tags   = {
    Environment = "${local.environment}"
    Owner       = "Marcus Tse"
    Contact     = "email"
    Project     = "Terragrunt Medium"
    }
  }
}

terraform {
  backend "s3" {
  }
}

EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# Locals
# ---------------------------------------------------------------------------------------------------------------------
locals {
  # Read terragrunt config parses the terragrunt config at the given path and serialises the result into a map that can 
  # be used to reference the values of the parsed config
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))

  # Global locals
  aws_region  = local.region_vars.locals.aws_region
  environment = local.environment_vars.locals.environment
}

inputs = merge(
  local.region_vars.locals,
  local.environment_vars.locals,
)


