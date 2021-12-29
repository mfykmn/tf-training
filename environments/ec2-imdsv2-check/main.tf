data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = data.aws_vpc.default.cidr_block
}

resource "aws_instance" "imds_v2_not_only_enabled" {
  ami           = "ami-0e60b6d05dc38ff11"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  tags          = {
    Name = "imds_v2_not_only_enabled"
  }
}

resource "aws_instance" "imds_v2_only_enabled" {
  ami           = "ami-0e60b6d05dc38ff11"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  tags          = {
    Name = "imds_v2_only_enabled"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required" # IMDSv2のみ許可
  }
}