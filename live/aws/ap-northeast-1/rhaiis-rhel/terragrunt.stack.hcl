locals {
  os_version = "rhel9"
}

stack "rhaiis" {
  source = "${get_repo_root()}/catalog/stacks/rhaiis"
  path   = "rhaiis"

  values = {
    ami           = "ami-0938769ffbe276d3b"
    instance_type = "g6e.2xlarge"
    volume        = 100
    counts        = 1
    os_version    = local.os_version
  }
}
