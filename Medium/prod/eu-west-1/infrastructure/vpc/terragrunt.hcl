terraform {
  extra_arguments "init_args" {
    commands = [
      "init"
    ]
    arguments = [
    ]
  }
}

include "root" {
  path = find_in_parent_folders()
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/Medium/_commonvars/vpc.hcl"
  expose = true
}

inputs = {
  cidr            = "10.1.0.0/16"
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
}