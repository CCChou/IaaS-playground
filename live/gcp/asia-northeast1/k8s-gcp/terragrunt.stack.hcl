stack "k8s_gcp" {
  source = "${get_repo_root()}/catalog/stacks/k8s-gcp"
  path   = "k8s-gcp"

  values = {
    image        = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    machine_type = "n1-standard-4"
    volume       = 100
    counts       = 1
    preemptible  = true
    gpu_type     = "nvidia-tesla-t4"
    gpu_count    = 1
  }
}
