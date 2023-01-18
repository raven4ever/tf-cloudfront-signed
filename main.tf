# Create storage bucket
resource "aws_s3_bucket" "storage_bucket" {
  name = var.bucket_name
  tags = var.tags
}

# Make the bucket private
resource "aws_s3_bucket_acl" "storage_bucket_acl" {
  bucket = aws_s3_bucket.storage_bucket.id
  acl    = "private"
}
