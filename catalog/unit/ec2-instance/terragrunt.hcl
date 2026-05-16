terraform {
  source = "${get_repo_root()}/modules//ec2-instance"
}

inputs = {
  instance_type = "t3.medium"
  counts        = 1
  volume        = 50
}
