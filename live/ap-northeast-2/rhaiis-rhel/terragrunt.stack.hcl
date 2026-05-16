locals {
  os_version = "rhel9"
}

stack "rhaiis" {
  source = "${get_repo_root()}/catalog/stacks/rhaiis"
  path   = "rhaiis"

  values = {
    ami           = "ami-09e34074d412a97b2"
    instance_type = "g6.xlarge"
    volume        = 100
    counts        = 2
    os_version    = local.os_version
  }
}
