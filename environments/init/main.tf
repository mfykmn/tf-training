#####################################
# Management of tfstate
#####################################
terraform {
  required_version = "0.11.11"
}

provider "aws" {
  version = "1.3.1"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "tf-training.tfstate"
  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "tfstate-lock" {
  name           = "tf-training.tfstate-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
}