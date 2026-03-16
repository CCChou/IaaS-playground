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

resource "aws_instance" "rhaiis_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.name
  vpc_security_group_ids = [aws_security_group.rhaiis_server_sg.id]
  user_data              = file("${path.module}/files/setup-${var.os_version}.sh")
  count                  = var.counts

  root_block_device {
    volume_size = var.volume
  }

  tags = {
    Name = var.name
  }
}

resource "aws_key_pair" "rhaiis_server_keypair" {
  key_name   = var.name
  public_key = var.ssh_public_key
}

resource "aws_security_group" "rhaiis_server_sg" {
  name = "${var.name}_sg"

  ingress = [{
    description      = "Allow Dashboard"
    from_port        = 3000
    to_port          = 3001
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    },
    {
      description      = "Allow SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "Allow HTTP"
      from_port        = 8000
      to_port          = 8000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
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
  value       = aws_instance.rhaiis_server[*].public_dns
}
