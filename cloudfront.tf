# Create CloudFront OAI
resource "aws_cloudfront_origin_access_identity" "storage_bucket_oai" {
  comment = "OAI to access storage bucket"
}

# Create CloudFront distribution
resource "aws_cloudfront_distribution" "storage_bucket_distribution" {
  enabled             = true
  default_root_object = "index.html"
  tags                = var.tags

  origin {
    domain_name = aws_s3_bucket.storage_bucket.bucket_regional_domain_name
    origin_id   = var.bucket_name
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.storage_bucket_oai.cloudfront_access_identity_path
    }
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

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "404.html"
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
