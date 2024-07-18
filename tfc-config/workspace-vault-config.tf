resource "tfe_workspace" "vault_config" {
  name         = "vault-config"
  organization = data.tfe_organization.org.name
  queue_all_runs = false
  vcs_repo {
    branch = "main"
    identifier = "hashicorp/ILM-SLM-automation"
    github_app_installation_id = data.tfe_github_app_installation.gha_installation.id
  }
  working_directory = "/vault-config"
  trigger_patterns = ["/vault-config/*.tf"]
  project_id = tfe_project.ilm_slm_automation.id
  remote_state_consumer_ids = [
    tfe_workspace.aws_ec2.id,
    tfe_workspace.boundary_config.id
  ]
}

resource "tfe_variable" "vault_ws_org" {
  key          = "tfc_org"
  value        = var.tfc_org
  category     = "terraform"
  workspace_id = tfe_workspace.vault_config.id
  description  = "Terraform Cloud Org Name"
}

resource "tfe_workspace_variable_set" "vault_var_set" {
  workspace_id    = tfe_workspace.vault_config.id
  variable_set_id = tfe_variable_set.vault_creds_vars.id
}

resource "tfe_variable" "user_for_boundary" {
  key          = "boundary_username"
  value        = data.terraform_remote_state.hcp.outputs.boundary_username
  category     = "terraform"
  workspace_id = tfe_workspace.vault_config.id
  description  = "Boundary user"
}

resource "tfe_variable" "pwd_for_boundary" {
  key          = "boundary_password"
  value        = data.terraform_remote_state.hcp.outputs.boundary_password
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.vault_config.id
  description  = "Boundary password"
}

resource "tfe_variable" "url_for_boundary" {
  key          = "boundary_url"
  value        = data.terraform_remote_state.hcp.outputs.boundary_url
  category     = "terraform"
  workspace_id = tfe_workspace.vault_config.id
  description  = "Boundary url"
}