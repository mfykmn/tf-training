#####################################
# AWS provider settings
#####################################
provider "aws" {
  version = "~> 2.8"
  region  = var.region
}

data "aws_caller_identity" "current" {
}
