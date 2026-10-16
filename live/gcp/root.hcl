locals {
  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract the variables we need for easy access
  gcp_region = local.region_vars.locals.gcp_region
  gcp_zone   = local.region_vars.locals.gcp_zone
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  region = "${local.gcp_region}"
  zone   = "${local.gcp_zone}"
}
EOF
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket = "dennis-iaas-gcp-${local.gcp_region}"
    prefix = "${path_relative_to_include()}/tofu.tfstate"
  }
}
