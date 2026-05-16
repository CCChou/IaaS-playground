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

resource "aws_s3_bucket" "aap" {
  bucket = "iaas-playground-aap"

  tags = {
    Name = "aap"
  }
}

resource "aws_s3_object" "aap-container-setup" {
  bucket = aws_s3_bucket.aap.id
  key    = "aap-container-setup.tar.gz"
  source = var.aap_file
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2-s3-access"
  role = aws_iam_role.ec2_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.aap.arn}/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "aio_aap" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "aio_aap"
  vpc_security_group_ids = [aws_security_group.aio_aap_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  user_data = templatefile("${path.module}/aap-setup.sh", {
    BUCKET      = "${aws_s3_bucket.aap.bucket}"
    FILE        = "${aws_s3_object.aap-container-setup.key}"
    RH_USERNAME = var.rh_username
    RH_PASSWORD = var.rh_password
    USER_HOME     = "/home/ec2-user"
  })

  root_block_device {
    volume_size = 60
  }

  tags = {
    Name = "AIO-AAP"
  }

  depends_on = [aws_s3_object.aap-container-setup]
}

resource "aws_key_pair" "aio_aap_keypair" {
  key_name   = "aio_aap"
  public_key = var.ssh_public_key
}

resource "aws_security_group" "aio_aap_sg" {
  name = "aio_aap_sg"

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
      description      = "Allow HTTPS"
      from_port        = 443
      to_port          = 443
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
    Name = "aio_aap_sg"
  }
}
