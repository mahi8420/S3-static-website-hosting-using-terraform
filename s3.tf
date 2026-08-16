provider "aws" {
    region = var.aws_region
  
}

resource "aws_s3_bucket" "my_web_842_bucket" {
  bucket = "my-web-842-bucket"
}

resource "aws_s3_bucket_public_access_block" "my_web_842_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_web_842_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "my_web_842_bucket_website" {
  bucket = aws_s3_bucket.my_web_842_bucket.id
  index_document {
    suffix = "test_site.htm"
  }
}

resource "aws_s3_bucket_policy" "my_web_842_bucket_policy" {
  bucket = aws_s3_bucket.my_web_842_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AddPerm"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::474726787585:user/mahima-admin"
        }
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject"
        ]
        Resource = [
            "arn:aws:s3:::my-web-842-bucket",
            "arn:aws:s3:::my-web-842-bucket/*"
        ]
      }
    ]
  })
}