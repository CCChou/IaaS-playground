terraform {
  backend "s3" {
    bucket         = "iaas-playground-dennis"
    key            = "workshops/k8s-hami/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
