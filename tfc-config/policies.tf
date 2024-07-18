# Create an admins policy in the test namespace
resource "vault_policy" "jwt_dynamic_cred_policy" {
  name          = "tfc-policy"
  policy        = file("./policies/tfc-policy.hcl")
}