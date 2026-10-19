include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules//aws-ec2-instance"
}

dependency "default_vpc" {
  config_path = "../default-vpc"

  mock_outputs = {
    id = "vpc-00000000"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan", "init", "destroy"]
}

inputs = {
  name               = values.name
  vpc_id             = dependency.default_vpc.outputs.id
  ami                = values.ami
  instance_type      = values.instance_type
  volume             = values.volume
  counts             = values.counts
  allow_self_ingress = values.allow_self_ingress
  cloud_init_parts   = values.cloud_init_parts
}
