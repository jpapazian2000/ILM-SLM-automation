resource "tfe_workspace_run" "ws_run_aws_infra" {
  workspace_id    = tfe_workspace.aws_infra.id

  apply {
    manual_confirm    = true
    wait_for_run      = true
    retry             = false
  }
}

resource "tfe_run_trigger" "aws_infra_to_vault" {
  workspace_id = tfe_workspace.vault_config.id
  sourceable_id = tfe_workspace.aws_infra.id
}

resource "tfe_run_trigger" "vault_to_aws_ec2" {
  workspace_id = tfe_workspace.aws_ec2.id
  sourceable_id = tfe_workspace.vault_config.id
}

resource "tfe_run_trigger" "aws_ec2_to_boundary" {
  workspace_id = tfe_workspace.boundary_config.id
  sourceable_id = tfe_workspace.aws_ec2.id
}