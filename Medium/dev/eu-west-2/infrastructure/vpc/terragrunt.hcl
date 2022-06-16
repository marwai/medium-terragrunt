include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git//?ref=v3.11.0"

  extra_arguments "init_args" {
    commands = [
      "init"
    ]

    arguments = [
    ]
  }
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/Medium/_commonvars/vpc.hcl"
  expose = true
}

inputs = {
  cidr            = "10.0.0.0/16"
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}