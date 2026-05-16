locals {
  os_version = "ubuntu2404"
}

unit "default_vpc" {
  source = "${get_repo_root()}/catalog/unit/default-vpc"
  path   = "default-vpc"
}

unit "rhaiis" {
  source = "${get_repo_root()}/catalog/unit/ec2-instance"
  path   = "rhaiis"

  inputs = {
    name          = "rhaiis"
    ami           = "ami-0ba8d27d35e9915fb" # Ubuntu 24.04 in ap-southeast-2
    instance_type = "g6.2xlarge"
    volume        = 100
    user_data     = file("${get_repo_root()}/catalog/stack/rhaiis/files/setup-${local.os_version}.sh")
  }
}
