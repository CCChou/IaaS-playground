terraform {
  source = "${get_repo_root()}/modules//sg-rule"
}

inputs = {
  type     = "ingress"
  protocol = "tcp"
}
