provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.name
  vpc_security_group_ids = [aws_security_group.ec2_instance_sg.id]
  #   user_data              = file("${path.module}/files/setup-${var.os_version}.sh")
  count = var.counts

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

resource "aws_security_group" "ec2_instance_sg" {
  name = "${var.name}_sg"

  tags = {
    Name = "${var.name}_sg"
  }
}

module "allow_outbound_all" {
  source = "../sg-rule"

  security_group_id = aws_security_group.ec2_instance_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "allow_inbound_ssh" {
  source = "../sg-rule"

  security_group_id = aws_security_group.ec2_instance_sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
