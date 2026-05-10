terraform {
  source = "../modules//ec2-instance"
}

inputs = {
  counts = 2
}