resource "boundary_worker" "session_rec_worker" {
  count = var.num_workers
  scope_id                    = "global"
  name                        = "${var.worker_name}-${count.index}"
  worker_generated_auth_token = ""
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  priv_ssh_key_real = coalesce(var.priv_ssh_key,var.pub_ssh_key)
}

# data "hcp_packer_iteration" "boundary_target" {
#   bucket_name = "boundary-target"
#   channel     = "latest"
# }

# data "hcp_packer_image" "ubuntu_us_east_1" {
#   bucket_name    = "boundary-target"
#   cloud_provider = "aws"
#   iteration_id   = data.hcp_packer_iteration.boundary_target.ulid
#   region         = var.region
# }

resource "aws_instance" "worker" {
  count                         = var.num_workers
  ami                           = data.aws_ami.ubuntu.id
  instance_type                 = "t3.micro"
  subnet_id                     = data.terraform_remote_state.aws_infra.outputs.subnet.*.id[count.index]
  key_name                      = data.terraform_remote_state.aws_ec2.outputs.key_name
  vpc_security_group_ids        = [data.terraform_remote_state.aws_ec2.outputs.security_group]
  associate_public_ip_address   = true
  tags = {
    #Name = "${var.tag}-${random_pet.test.id}-worker-${count.index}"
    Name = "${var.tag}-worker-${count.index}"
  }
  connection {
    type         = "ssh"
    user         = "ubuntu"
    private_key  = local.priv_ssh_key_real
    host         = self.public_ip
  }
  provisioner "file" {
    content = templatefile("${path.module}/install/worker.hcl.tpl", {
      hcp_boundary_id        = var.boundary_cluster_id
      name_suffix            = var.tfc_org
      public_ip              = self.public_ip
      private_ip             = self.private_ip
      tag                    = var.worker_tag
      activation_token       = "${boundary_worker.session_rec_worker[count.index].controller_generated_activation_token}"
    })
    destination = "/tmp/boundary-worker.hcl"
  }

  provisioner "file" {
    source      = "${path.module}/install/install.sh"
    destination = "/home/ubuntu/install.sh"
  }

  user_data = <<EOF
#!/bin/bash

sudo mkdir -p /local/boundary/storage
sudo mkdir -p /local/boundary/worker1
sudo chmod 777 -R /local/boundary
sudo mkdir -p /var/lib/boundary

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install boundary-enterprise

sudo mv /tmp/boundary-worker.hcl /etc/boundary-worker.hcl

sudo chmod 0755 /home/ubuntu/install.sh
sudo /home/ubuntu/install.sh worker
  EOF
}