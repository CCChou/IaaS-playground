locals {
  use_cloud_init = length(var.cloud_init_parts) > 0
}

data "cloudinit_config" "setup" {
  count         = local.use_cloud_init ? 1 : 0
  gzip          = true
  base64_encode = true

  dynamic "part" {
    for_each = var.cloud_init_parts
    content {
      filename     = part.value.filename
      content_type = "text/x-shellscript"
      content      = part.value.content
    }
  }
}

resource "aws_instance" "ec2_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.name
  vpc_security_group_ids      = [aws_security_group.ec2_instance_sg.id]
  user_data                   = local.use_cloud_init ? null : var.user_data
  user_data_base64            = local.use_cloud_init ? data.cloudinit_config.setup[0].rendered : null
  user_data_replace_on_change = true
  count                       = var.counts

  root_block_device {
    volume_size = var.volume
  }

  tags = {
    Name = var.name
  }
}

resource "aws_key_pair" "ec2_instance_keypair" {
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

module "allow_self_ingress" {
  count  = var.allow_self_ingress ? 1 : 0
  source = "../sg-rule"

  security_group_id        = aws_security_group.ec2_instance_sg.id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.ec2_instance_sg.id
}
