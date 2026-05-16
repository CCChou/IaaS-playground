unit "default_vpc" {
  source = "${get_repo_root()}/catalog/units/default-vpc"
  path   = "default-vpc"
}

unit "k8s" {
  source = "${get_repo_root()}/catalog/units/ec2-instance"
  path   = "k8s"

  values = {
    name               = "k8s"
    ami                = values.ami
    instance_type      = values.instance_type
    volume             = values.volume
    counts             = values.counts
    allow_self_ingress = true
    cloud_init_parts = [
      {
        filename = "install-containerd.sh"
        content  = file("${get_repo_root()}/catalog/stacks/k8s/files/install-containerd.sh")
      },
      {
        filename = "install-kubeadm.sh"
        content  = file("${get_repo_root()}/catalog/stacks/k8s/files/install-kubeadm.sh")
      }
    ]
  }
}
