locals {
  defaults = {
    cloud_init_parts   = ""
    user_data          = ""
    allow_self_ingress = true
  }
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules//ec2-instance"
}

inputs = {
  ami                = values.ami
  instance_type      = values.instance_type
  volume             = values.volume
  counts             = values.counts
  allow_self_ingress = values.allow_self_ingress
  cloud_init_parts   = values.cloud_init_parts
}
