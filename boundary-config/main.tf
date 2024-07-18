terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.82.0"
    }
  }
}

data "terraform_remote_state" "hcp_vault_manage" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "vault-config"
    }
  }
}

data "terraform_remote_state" "aws_infra" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "aws-infra"
    }
  }
}

data "terraform_remote_state" "aws_ec2" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "aws-ec2"
    }
  }
}

resource "random_pet" "test" {
  length = 1
}

provider "aws" {
  region  = var.region
}

provider "hcp" {}


provider "boundary" {
  addr                            = data.terraform_remote_state.hcp_vault_manage.outputs.boundary_url
  auth_method_login_name          = data.terraform_remote_state.hcp_vault_manage.outputs.boundary_username
  auth_method_password            = data.terraform_remote_state.hcp_vault_manage.outputs.boundary_password
}
