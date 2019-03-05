#####################################
# Management of tfstate
#####################################
terraform {
  required_version = "0.11.11"

  backend "s3" {
    bucket     = "tf-training.tfstate"
    key        = "mutable/terraform.tfstate"
    region     = "us-east-1"
    lock_table = "tf-training.tfstate-lock"
    encrypt    = true
  }
}