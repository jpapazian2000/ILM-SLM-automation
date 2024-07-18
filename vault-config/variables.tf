# variable "private_key" {
#     type        = string
#     sensitive   = true
# }

variable "tfc_org" {
  type = string
}

variable "boundary_username" {
  type = string
}

variable "boundary_password" {
  type = string
  sensitive = true
}

variable "boundary_url" {
  type = string
}