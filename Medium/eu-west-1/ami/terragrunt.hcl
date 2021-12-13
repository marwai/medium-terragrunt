include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//ami"

  extra_arguments "init_args" {
    commands = [
      "init"
    ]

    arguments = [
    ]
  }
}



inputs = {

  tags = {
    Service     = "external-alb"
    Owner       = "Marcus"
    Contact     = "marcus.tse"
    Project     = "Terragrunt Medium"
    Environment = "Development"
  }
}