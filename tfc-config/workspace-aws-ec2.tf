resource "tfe_workspace" "aws_ec2" {
  name         = "aws-ec2"
  organization = data.tfe_organization.org.name
  queue_all_runs = false
  vcs_repo {
    branch = "main"
    identifier = "hashicorp/ILM-SLM-automation"
    github_app_installation_id = data.tfe_github_app_installation.gha_installation.id
  }
  working_directory = "/aws-ec2"
  trigger_patterns = ["/aws-ec2/*.tf"]
  project_id = tfe_project.ilm_slm_automation.id
  remote_state_consumer_ids = [
    tfe_workspace.boundary_config.id
  ]
}

resource "tfe_variable" "aws_ec2_ws_org" {
  key          = "tfc_org"
  value        = var.tfc_org
  category     = "terraform"
  workspace_id = tfe_workspace.aws_ec2.id
  description  = "Terraform Cloud Org Name"
}

resource "tfe_variable" "tag" {
  key          = "tag"
  value        = var.aws_resources_tag
  category     = "terraform"
  workspace_id = tfe_workspace.aws_ec2.id
  description  = "AWS resources tag"
}

resource "tfe_variable" "pub_ssh_key" {
  key          = "pub_ssh_key"
  value        = var.pub_ssh_key
  category     = "terraform"
  workspace_id = tfe_workspace.aws_ec2.id
  description  = "Your public key for EC2 ssh backdoor"
}

resource "tfe_variable" "priv_ssh_key" {
  key          = "priv_ssh_key"
  value        = var.priv_ssh_key
  category     = "terraform"
  sensitive    = true
  workspace_id = tfe_workspace.aws_ec2.id
  description  = "Your private key for EC2 ssh backdoor"
}

resource "tfe_variable" "aws_ec2_access_key_id" {
  key = "AWS_ACCESS_KEY_ID"
  value = var.aws_access_key_id
  category = "env"
  workspace_id = tfe_workspace.aws_ec2.id
  description = "AWS Access Key ID"
}

resource "tfe_variable" "aws_ec2_secret_access_key" {
  key = "AWS_SECRET_ACCESS_KEY"
  value = var.aws_secret_access_key
  category = "env"
  sensitive = true
  workspace_id = tfe_workspace.aws_ec2.id
  description = "AWS Secret Access Key"
}

resource "tfe_variable" "aws_ec2_region" {
  key = "region"
  value = var.aws_region
  category = "terraform"
  workspace_id = tfe_workspace.aws_ec2.id
  description = "AWS region"
}