####################
# VPC
####################
data "aws_vpc" "default" {
  default = true
}

variable availability_zones {
  type = map(string)
  default = {
    0 = "ap-northeast-1a",
    1 = "ap-northeast-1c",
  }
}

resource "aws_subnet" "main" {
  count = 2

  availability_zone = var.availability_zones[count.index]
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = cidrsubnet(data.aws_vpc.default.cidr_block, 8, count.index)
}

####################
# S3
####################
resource "aws_s3_bucket" "alb_logs" {
  bucket = "ALB-AccessLogs"
  acl    = "private"

  # S3バケットのデフォルト暗号化
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

data "aws_elb_service_account" "main" {}

data "aws_iam_policy_document" "alb_logs" {
  statement {
    effect    = "Allow"
    actions   = [ "s3:PutObject" ]
    resources = [ "${aws_s3_bucket.alb_logs.arn}/*" ]
    principals {
      type = "AWS"
      identifiers = [ data.aws_elb_service_account.main.arn ]
    }
  }
}

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id
  policy = data.aws_iam_policy_document.alb_logs.json
}

####################
# ALB
####################
resource "aws_default_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_alb" "alb" {
  name                       = "elb-logging-enabled"
  security_groups            = [aws_default_security_group.default.id]
  subnets                    = [aws_subnet.main[0].id, aws_subnet.main[1].id]
  internal                   = false
  enable_deletion_protection = false
# コメントアウトを外すとSecurity Hubは準拠の状態になる
#  access_logs {
#    bucket  = aws_s3_bucket.alb_logs.bucket
#    prefix  = "myapp"
#    enabled = true
#  }
}
