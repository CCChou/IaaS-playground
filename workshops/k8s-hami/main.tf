module "k8s" {
  source        = "../../modules/k8s"
  name          = "k8s-hami"
  instance_type = "g6.xlarge"
  region        = "ap-northeast-2"
  ami           = "ami-0765f9741eedf9c7b"
  volume        = 150
  counts        = 2
}
