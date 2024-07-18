hcp_boundary_cluster_id="${hcp_boundary_id}"
disable_mlock = true
listener "tcp" {
  address = "${private_ip}:9202"
  purpose = "proxy"
}

worker {
  # Name attr must be unique
	public_addr = "${public_ip}"
  recording_storage_path = "/local/boundary/storage"
  auth_storage_path = "/local/boundary/worker1"
  controller_generated_activation_token = "${activation_token}"
  tags {
    type = ["${tag}"]
  }
}