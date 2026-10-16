unit "default_network" {
  source = "${get_repo_root()}/catalog/units/gcp-default-network"
  path   = "default-network"
}

unit "k8s" {
  source = "${get_repo_root()}/catalog/units/gce-instance"
  path   = "k8s"

  values = {
    name               = "k8s"
    image              = values.image
    machine_type       = values.machine_type
    volume             = values.volume
    counts             = values.counts
    allow_self_ingress = true
    preemptible        = values.preemptible
    gpu_type           = values.gpu_type
    gpu_count          = values.gpu_count
    cloud_init_parts = [
      {
        filename = "install-containerd.sh"
        content  = file("${get_repo_root()}/catalog/scripts/k8s/install-containerd.sh")
      },
      {
        filename = "install-kubeadm.sh"
        content  = file("${get_repo_root()}/catalog/scripts/k8s/install-kubeadm.sh")
      }
    ]
  }
}
