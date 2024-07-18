terraform {
  required_providers {
    vault = "~> 3.19.0"
  }
}

data "terraform_remote_state" "aws_resources" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "aws-infra"
    }
  }
}
