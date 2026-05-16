terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

data "cloudinit_config" "setup" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "install-containerd.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/files/install-containerd.sh")
  }

  part {
    filename     = "install-kubeadm.sh"
    content_type = "text/x-shellscript"
    content      = file("${path.module}/files/install-kubeadm.sh")
  }
}

resource "aws_instance" "k8s" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.name
  vpc_security_group_ids      = [aws_security_group.k8s_sg.id]
  user_data_base64            = data.cloudinit_config.setup.rendered
  user_data_replace_on_change = true
  count                       = var.counts

  root_block_device {
    volume_size = var.volume
  }

  tags = {
    Name = var.name
  }
}

resource "aws_key_pair" "k8s_keypair" {
  key_name   = var.name
  public_key = var.ssh_public_key
}

resource "aws_security_group" "k8s_sg" {
  name = "${var.name}_sg"

  ingress = [{
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    },
    {
      description      = "Allow All Internally"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = true
  }]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}_sg"
  }
}

output "public_dns" {
  description = "Public DNS names of the EC2 instances (accessible from the Internet)"
  value       = aws_instance.k8s[*].public_dns
}
