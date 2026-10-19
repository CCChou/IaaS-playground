include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules//gce-instance"
}

dependency "default_network" {
  config_path = "../default-network"

  mock_outputs = {
    self_link = "projects/mock-project/global/networks/mock"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan", "init", "destroy"]
}

inputs = {
  name               = values.name
  network            = dependency.default_network.outputs.self_link
  image              = values.image
  machine_type       = values.machine_type
  volume             = values.volume
  counts             = values.counts
  allow_self_ingress = values.allow_self_ingress
  cloud_init_parts   = values.cloud_init_parts
  preemptible        = values.preemptible
  gpu_type           = values.gpu_type
  gpu_count          = values.gpu_count
}
