module "rhaiis_server" {
  source = "../../modules/rhaiis"
  name = "rhaiis-benchmark"
  instance_type = "g6e.12xlarge"
  region = "ap-northeast-2"
  ami = "ami-099fd0c9728cca0e5"
  os_version = "rhel9"
  volume = 150
}
