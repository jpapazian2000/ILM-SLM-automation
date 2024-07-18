output "boundary_username" {
  value = data.terraform_remote_state.hcp.outputs.boundary_username
}
output "boundary_password" {
  value = data.terraform_remote_state.hcp.outputs.boundary_password
  sensitive = true
}
output "boundary_url" {
  value = data.terraform_remote_state.hcp.outputs.boundary_url
}