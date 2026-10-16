locals {
  os_version = "ubuntu2404"
}

stack "rhaiis" {
  source = "${get_repo_root()}/catalog/stacks/rhaiis"
  path   = "rhaiis"

  values = {
    ami           = "ami-0150847fe1b89b004"
    instance_type = "g6.xlarge"
    volume        = 100
    counts        = 2
    os_version    = local.os_version
  }
}
