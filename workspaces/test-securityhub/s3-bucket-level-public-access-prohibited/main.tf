####################
# S3
####################
resource "aws_s3_bucket" "public" { bucket = "security-hub-public-access-0011" }

resource "aws_s3_bucket" "private" { bucket = "security-hub-private-access-0011" }
resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.private.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}