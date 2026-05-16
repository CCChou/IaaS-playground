stack "k8s" {
  source = "${get_repo_root()}/catalog/stacks/k8s"
  path   = "k8s"

  values = {
    ami           = "ami-0765f9741eedf9c7b"
    instance_type = "g6.xlarge"
    volume        = 100
    counts        = 2
  }
}