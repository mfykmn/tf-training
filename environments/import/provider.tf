#####################################
# AWS Authentication
#####################################
provider "aws" {
  version = "1.3.1"
  region  = "${var.region}"
}