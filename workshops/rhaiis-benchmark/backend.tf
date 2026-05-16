terraform {
  backend "s3" {
    bucket         = "iaas-playground-dennis"
    key            = "workshops/rhaiis-benchmark/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
