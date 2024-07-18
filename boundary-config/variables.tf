variable "tfc_org" {
  type = string
}

variable "vault_addr" {
  type = string
}

variable "aws_key_id" {
  type = string
}

variable "aws_secret_key" {
  type = string
  sensitive = true
}

variable "tag" {
  type = string
}

variable "pub_ssh_key" {
  type = string
}

variable "priv_ssh_key" {
  default = ""
}

variable "boundary_cluster_id" {
  type = string
}

variable "region" {
  type = string
}

variable "worker_name" {
  type = string
}

variable "num_workers" {
  type = string
}

variable "worker_tag" {
  type = string
}