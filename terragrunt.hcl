remote_state {
  backend = "s3"
  config = {
    bucket  = "medium-terragrunt-example"
    key     = "terragrunted/${path_relative_to_include()}.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}