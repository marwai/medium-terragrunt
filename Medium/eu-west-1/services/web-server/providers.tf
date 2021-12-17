provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      Service     = "web-server"
      Owner       = "Marcus"
      Contact     = "marcus.tse"
      Project     = "Terragrunt Medium"
      Environment = "Development"
    }
  }
}

terraform {
  backend "s3" {
  }
}
