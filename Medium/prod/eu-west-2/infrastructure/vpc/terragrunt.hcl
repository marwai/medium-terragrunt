include {
  path = find_in_parent_folders()
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/Medium/_commonvars/vpc.hcl"
  expose = true
}

inputs = {
  cidr            = "10.1.0.0/16"
  private_subnets = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
  public_subnets  = ["10.1.104.0/24", "10.1.105.0/24", "10.1.106.0/24"]
}