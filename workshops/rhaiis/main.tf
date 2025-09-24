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
  key_name               = "rhaiis_server"
  vpc_security_group_ids = [aws_security_group.rhaiis_server_sg.id]
  user_data              = file("${path.module}/nvidia-driver.sh")

  root_block_device {
    volume_size = 100
  }

  tags = {
    Name = "RHAIIS-Server"
  }
}

resource "aws_key_pair" "rhaiis_server_keypair" {
  key_name   = "rhaiis_server"
  public_key = var.ssh_public_key
}

resource "aws_security_group" "rhaiis_server_sg" {
  name = "rhaiis_server_sg"

  ingress = [{
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
      from_port        = 9000
      to_port          = 9000
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
    Name = "rhaiis_server_sg"
  }
}
