unit "default_vpc" {
  source = "${get_repo_root()}/catalog/unit/default-vpc"
  path   = "default-vpc"
}

unit "k8s" {
  source = "${get_repo_root()}/catalog/unit/ec2-instance"
  path   = "k8s"

  inputs = {
    name               = "k8s"
    ami                = "ami-0c33c6bd24cee108b" # Ubuntu 24.04 in ap-southeast-2
    instance_type      = "g6.xlarge"
    volume             = 100
    allow_self_ingress = true
    cloud_init_parts = [
      {
        filename = "install-containerd.sh"
        content  = file("${get_repo_root()}/catalog/stack/k8s/files/install-containerd.sh")
      },
      {
        filename = "install-kubeadm.sh"
        content  = file("${get_repo_root()}/catalog/stack/k8s/files/install-kubeadm.sh")
      }
    ]
  }
}
