remote_state {
  backend = "s3"
  config = {
    bucket  = "medium-terragrunt-example"
    key     = "terragrunted/${path_relative_to_include()}.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}

# Indicate what region to deploy the resources into
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "eu-west-1"

terraform {
  backend "s3" {
  }
}
}
EOF
}

