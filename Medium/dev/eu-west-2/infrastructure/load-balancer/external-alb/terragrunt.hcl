include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/Medium/_commonvars/load-balancer.hcl"
  expose = true
}

inputs = {}