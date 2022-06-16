include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/Medium/_commonvars/load-balancer-sg.hcl"
  expose = true
}

inputs = {
}

