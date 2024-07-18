terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.65.0"
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


provider "aws" {
  region  = var.region
}

resource "random_pet" "test" {
  length = 1
}