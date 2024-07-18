# Create an admins policy in the test namespace
resource "vault_policy" "admin_policy" {
  name          = "admins"
  policy        = file("policies/admin-policy.hcl")
}

resource "vault_policy" "boundary-policy" {
  name = "boundary-policy"
  policy = file("policies/boundary-policy.hcl")
}

resource "vault_policy" "boundary-read" {
  name = "boundary-read"
  policy = file("policies/boundary-read.hcl")
}

resource "vault_policy" "boundary-ssh" {
  name = "boundary-ssh"
  policy = file("policies/boundary-ssh.hcl")
}

resource "vault_policy" "db" {
  name = "db-policy"
  policy = file("policies/db-policy.hcl")
}