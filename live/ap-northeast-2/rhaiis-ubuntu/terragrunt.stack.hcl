# 從 catalog 拉一個既有的 stack 當 base
locals {
  os_version = "ubuntu2404"
}

stack "rhaiis" {
  source = "${get_repo_root()}/catalog/stacks/rhaiis"
  path   = "rhaiis"

  values = {
    ami           = "ami-0765f9741eedf9c7b"
    instance_type = "g6.xlarge"
    volume        = 100
    counts        = 2
    os_version    = local.os_version
  }
}
