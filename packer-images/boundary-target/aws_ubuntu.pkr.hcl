packer {
    required_plugins {
        amazon = {
            version = ">= 1.1.0"
            source  = "github.com/hashicorp/amazon"
        }
    }
}

source "amazon-ebs" "ubuntu-boundary-target" {
    ami_name      = "Boundary Target"
    instance_type = "t3.micro"
    region        = "us-east-1"
    source_ami    =  "ami-0e3a6d8ff4c8fe246"
    subnet_id     = "subnet-0acf3895bb27c5e46"
    ssh_private_key_file = ""
    tags = {
        "Name" = "Kojak's packer image for eu-west-1 "
    }
    ssh_username = "ubuntu"
}


build {
    hcp_packer_registry {
        bucket_name = "boundary-target"
        description = <<EOT
            Images for ubuntu.
            EOT
    }
    name = "ubuntu-aws"
    sources = [
        "source.amazon-ebs.ubuntu-boundary-target",
    ]

    provisioner "shell" {
        inline = [
            "echo Update Upgrade Clean apt"
        ]
    }
}

