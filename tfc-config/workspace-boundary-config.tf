resource "tfe_workspace" "boundary_config" {
  name         = "boundary-config"
  organization = data.tfe_organization.org.name
  queue_all_runs = false
  vcs_repo {
    branch = "main"
    identifier = "hashicorp/ILM-SLM-automation"
    github_app_installation_id = data.tfe_github_app_installation.gha_installation.id
  }
  working_directory = "/boundary-config"
  trigger_patterns = ["/boundary-config/*.tf"]
  project_id = tfe_project.ilm_slm_automation.id
}

resource "tfe_variable" "boundary_ws_tfc_org" {
  key          = "tfc_org"
  value        = var.tfc_org
  category     = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description  = "Terraform Cloud Org Name"
}

resource "tfe_workspace_variable_set" "boundary_var_set" {
  workspace_id    = tfe_workspace.boundary_config.id
  variable_set_id = tfe_variable_set.vault_creds_vars.id
}


resource "tfe_variable" "vault_addr_for_boundary" {
  key          = "vault_addr"
  value        = data.terraform_remote_state.hcp.outputs.hcp_vault_public_addr
  category     = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description  = "Vault Address"
}

resource "tfe_variable" "aws_s3_access_key" {
  key = "aws_key_id"
  value = var.aws_access_key_id
  category = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description = "AWS Access Key for Session Recording"
}

resource "tfe_variable" "aws_s3_secret_key" {
  key = "aws_secret_key"
  value = var.aws_secret_access_key
  category = "terraform"
  sensitive = true
  workspace_id = tfe_workspace.boundary_config.id
  description = "AWS Secret Key for Session Recording"
}

resource "tfe_variable" "boundary_cluster_id" {
  key = "boundary_cluster_id"
  value = split(".", split("//", data.terraform_remote_state.hcp.outputs.boundary_url)[1])[0]
  category = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description = "HCP Boundary cluster id"
}

resource "tfe_variable" "worker_pub_ssh_key" {
  key          = "pub_ssh_key"
  value        = var.pub_ssh_key
  category     = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description  = "Pub Key for Worker"
}

resource "tfe_variable" "worker_priv_ssh_key" {
  key          = "priv_ssh_key"
  value        = var.priv_ssh_key
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.boundary_config.id
  description  = "Priv Key for Worker"
}

resource "tfe_variable" "worker_resource_tag" {
  key          = "tag"
  value        = var.aws_resources_tag
  category     = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description  = "Worker Tag"
}

resource "tfe_variable" "worker_region" {
  key = "region"
  value = var.aws_region
  category = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description = "AWS region"
}

resource "tfe_variable" "worker_name" {
  key = "worker_name"
  value = var.worker_name
  category = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description = "Worker Name"
}

resource "tfe_variable" "worker_access_key_id" {
  key = "AWS_ACCESS_KEY_ID"
  value = var.aws_access_key_id
  category = "env"
  workspace_id = tfe_workspace.boundary_config.id
  description = "AWS Access Key ID"
}

resource "tfe_variable" "worker_secret_access_key" {
  key = "AWS_SECRET_ACCESS_KEY"
  value = var.aws_secret_access_key
  category = "env"
  sensitive = true
  workspace_id = tfe_workspace.boundary_config.id
  description = "AWS Secret Access Key"
}

resource "tfe_variable" "worker_nb" {
  key = "num_workers"
  value = "3"
  category = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description = "Worker Quantity"
}

resource "tfe_variable" "worker_tag" {
  key = "worker_tag"
  value = var.worker_tag
  category = "terraform"
  workspace_id = tfe_workspace.boundary_config.id
  description = "Worker Tag"
}