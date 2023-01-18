# Create storage bucket
resource "aws_s3_bucket" "storage_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

# Make the bucket private
resource "aws_s3_bucket_acl" "storage_bucket_acl" {
  bucket = aws_s3_bucket.storage_bucket.id
  acl    = "private"
}

# Enable encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "storage_bucket_encryption" {
  bucket = aws_s3_bucket.storage_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Upload demo content
resource "aws_s3_object" "storage_bucket_demo_content" {
  bucket = aws_s3_bucket.storage_bucket.id
  key    = "kitty-01.jpeg"
  source = "${path.module}/content/kitty-01.jpeg"
  etag   = filemd5("${path.module}/content/kitty-01.jpeg")
}

# Attach bucket policy
resource "aws_s3_bucket_policy" "storage_bucket_policy" {
  bucket = aws_s3_bucket.storage_bucket.id
  policy = data.aws_iam_policy_document.storage_bucket_policy_document.json
}

# Create CloudFront orgin access control
resource "aws_cloudfront_origin_access_control" "storage_bucket_distribution_oac" {
  name                              = "storage-bucket-distribution-oac"
  description                       = "Allow distribution from storage_bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Create CloudFront distribution
resource "aws_cloudfront_distribution" "storage_bucket_distribution" {
  enabled = true
  tags    = var.tags

  origin {
    domain_name              = aws_s3_bucket.storage_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.storage_bucket_distribution_oac.id
    origin_id                = var.bucket_name
  }

  default_cache_behavior {
    target_origin_id       = var.bucket_name
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
