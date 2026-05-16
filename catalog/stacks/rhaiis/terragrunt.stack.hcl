unit "default_vpc" {
  source = "${get_repo_root()}/catalog/units/default-vpc"
  path   = "default-vpc"
}

unit "rhaiis" {
  source = "${get_repo_root()}/catalog/units/ec2-instance"
  path   = "rhaiis"

  values = {
    name               = "rhaiis"
    ami                = values.ami
    instance_type      = values.instance_type
    volume             = values.volume
    counts             = values.counts
    allow_self_ingress = true
    cloud_init_parts = [
      {
        filename = "setup.sh"
        content  = file("${get_repo_root()}/catalog/stacks/rhaiis/files/setup-${values.os_version}.sh")
      }
    ]
  }
}
