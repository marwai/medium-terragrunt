include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/Medium/_commonvars/ec2.hcl"
  expose = true
}