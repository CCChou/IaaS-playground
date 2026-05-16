terraform {
  backend "s3" {
    bucket         = "iaas-playground-dennis"
    key            = "workshops/aap/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
