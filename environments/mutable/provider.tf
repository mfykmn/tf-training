#####################################
# AWS Authentication
#####################################
provider "aws" {
  version    = "~> 1.0"
  region     = "${var.region}"
}