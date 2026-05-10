remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket       = "dennis-iaas"
    key          = "${path_relative_to_include()}/tofu.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true
  }
}

# generate "backend" {
#   path      = "backend.tf"
#   if_exists = "overwrite_terragrunt"
#   contents = <<EOF
# terraform {
#   backend "s3" {
#     bucket         = "dennis-iaas"
#     key            = "${replace(path_relative_to_include(), "\\", "/")}/terraform.tfstate"
#     region         = "ap-southeast-2"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
# EOF
# }