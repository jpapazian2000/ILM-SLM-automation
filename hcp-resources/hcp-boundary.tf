resource "hcp_boundary_cluster" "boundary-cluster" {
  tier       = var.boundary_cluster_tier
  cluster_id = var.boundary_cluster_name
  username   = var.boundary_admin
  password   = var.boundary_admin_pass
}