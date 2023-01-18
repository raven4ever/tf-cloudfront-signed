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
