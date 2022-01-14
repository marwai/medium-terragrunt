include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../modules//web-server"

  extra_arguments "init_args" {
    commands = [
      "init"
    ]

    arguments = [
    ]
  }

}

dependency "vpc" {
  config_path = "../../infrastructure/vpc"
}

dependency "external_alb" {
  config_path = "../../infrastructure/load-balancer/external-alb"
}

dependency "external_security_group" {
  config_path = "../../infrastructure/load-balancer/external-security-group"
}

dependencies {
  paths = ["../../infrastructure//vpc", "../../infrastructure/load-balancer/external-alb", "../../infrastructure/load-balancer/external-security-group"]
}

inputs = {

  # VPC
  available_zones    = dependency.vpc.outputs.azs
  vpc_id             = dependency.vpc.outputs.vpc_id
  private_subnet_ids = dependency.vpc.outputs.private_subnets
  public_subnet_ids  = dependency.vpc.outputs.public_subnets

  # Set Inputs
  company_name     = "change-to-company-name"
  lb_ingress_rules = ["/32"]
  project_name     = "Terragrunt Medium"

  # listener configuration 
  external_lb_security_group_id = dependency.external_security_group.outputs.security_group_id
  external_lb_listener_arn      = dependency.external_alb.outputs.http_tcp_listener_arns[0]
  external_lb_name              = dependency.external_alb.outputs.lb_dns_name
  external_lb_zone_id           = dependency.external_alb.outputs.lb_zone_id
  external_target_group_arns    = dependency.external_alb.outputs.target_group_arns

  environment = "tools-eu-2"

  tags = {
    Name        = "Terragrunt-VPC"
    Owner       = "Marcus"
    Contact     = "marcus.tse"
    Project     = "Terragrunt Medium"
    Environment = "Development"
    Region      = "eu-west-2"
  }
}