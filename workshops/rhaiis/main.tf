module "rhaiis_server" {
  source = "../../modules/rhaiis"
}

# output "ec2_public_dns" {
#   value = module.rhaiis_server.instance_public_dns
# }