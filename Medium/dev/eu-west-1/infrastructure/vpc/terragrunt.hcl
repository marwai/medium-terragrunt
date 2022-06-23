include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/Medium/_commonvars/vpc.hcl"
  expose = true
}

include "root" {path = find_in_parent_folders()}

inputs = {
  cidr            = "10.0.0.0/16"
  private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  public_subnets  = ["10.0.104.0/24", "10.0.105.0/24", "10.0.106.0/24"]
}