resource "vault_jwt_auth_backend" "tfc" {
    description         = "TFC jwt backend"
    path                = "jwt"
    type                = "oidc"
    oidc_discovery_url  = "https://app.terraform.io"
    bound_issuer        = "https://app.terraform.io"
}

resource "vault_jwt_auth_backend_role" "tfc-role" {
  backend         = vault_jwt_auth_backend.tfc.path
  role_name       = var.tfc_role_name
  token_policies  = ["hcp-root"]
  bound_audiences = ["vault.workload.identity"]
  bound_claims_type = "glob"
  bound_claims = {
    "sub": "organization:${var.tfc_org}:project:*:workspace:*:run_phase:*"
  }
  user_claim      = "terraform_full_workspace"
  role_type       = "jwt"
  token_ttl       = "1200"
}

resource "tfe_variable_set" "vault_creds_vars" {
  name          = "Vault Dynamic Creds"
  description   = "Variables for Vault Dynamic Credentials"
  organization  = data.tfe_organization.org.name
}

resource "tfe_variable" "vault_env_var_provider" {
  key             = "TFC_VAULT_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  description     = "Requires v1.7.0 or later if self-managing agents. Must be present and set to true, or Terraform Cloud will not attempt to authenticate to Vault."
  variable_set_id = tfe_variable_set.vault_creds_vars.id
}

resource "tfe_variable" "vault_env_var_addr" {
  key             = "TFC_VAULT_ADDR"
  value           = data.terraform_remote_state.hcp.outputs.hcp_vault_public_addr
  category        = "env"
  description     = "The address of the Vault instance to authenticate against."
  variable_set_id = tfe_variable_set.vault_creds_vars.id
}

resource "tfe_variable" "vault_env_var_role" {
  key             = "TFC_VAULT_RUN_ROLE"
  value           = var.tfc_role_name
  category        = "env"
  description     = "The name of the Vault role to authenticate against."
  variable_set_id = tfe_variable_set.vault_creds_vars.id
}

resource "tfe_variable" "vault_env_var_ns" {
  key             = "TFC_VAULT_NAMESPACE"
  value           = "admin"
  category        = "env"
  description     = "The namespace to use when authenticating to Vault."
  variable_set_id = tfe_variable_set.vault_creds_vars.id
}