terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.65.0"
    }
  }
}

provider "aws" {
  region  = var.region
}

resource "random_pet" "test" {
  length = 1
}
