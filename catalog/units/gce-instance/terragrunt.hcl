include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules//gce-instance"
}

inputs = {
  name               = values.name
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
