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
# ALB
####################
resource "aws_default_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_alb" "alb" {
  name                       = "elb-protection"
  security_groups            = [aws_default_security_group.default.id]
  subnets                    = [aws_subnet.main[0].id, aws_subnet.main[1].id]
  internal                   = false
  # trueだと準拠になる
  # enable_deletion_protection = true
  enable_deletion_protection = false
}
