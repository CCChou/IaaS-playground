stack "k8s" {
  source = "${get_repo_root()}/catalog/stacks/k8s"
  path   = "k8s"

  values = {
    ami           = "ami-0150847fe1b89b004"
    instance_type = "g6.xlarge"
    volume        = 100
    counts        = 2
  }
}