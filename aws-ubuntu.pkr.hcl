
locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}


packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "debian" {
  ami_name        = "testing-image-${local.timestamp}"
  instance_type   = "t2.micro"
  region          = "us-east-1"
  ssh_username    = "admin"
  ami_description = "created from packer"
  source_ami_filter {
    filters = {
      name                = "debian-*-*-amd64-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm
    }
    most_recent = true
    owners      = ["136693071363"]
  }
  ami_users = ["171509565742"]

}



build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.debian"
  ]

  provisioner "file" {
    source      = "./webapp.zip"
    destination = "/home/admin/webapp.zip"
  }

  provisioner "file" {
    source      = "./webapp.service"
    destination = "/tmp/webapp.service"
  }

  provisioner "shell" {
    script = "./install.sh"
  }
}

