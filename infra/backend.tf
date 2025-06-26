terraform {
  backend "s3" {
    bucket  = "akyl-backet"
    key     = "ec2-ansible/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
