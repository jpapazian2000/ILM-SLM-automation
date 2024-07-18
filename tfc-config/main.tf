terraform {
  required_providers {
    vault = "~> 3.19.0"
    tfe = {
      version = "~> 0.53.0"
    }
  }
}


data "terraform_remote_state" "hcp" {
  backend = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = "hcp-resources"
    }
  }
}

provider "tfe" {
  token    = var.tfc_token
}

provider "vault" {
  token = data.terraform_remote_state.hcp.outputs.admin_token
  address = data.terraform_remote_state.hcp.outputs.hcp_vault_public_addr
  namespace = "admin"
}