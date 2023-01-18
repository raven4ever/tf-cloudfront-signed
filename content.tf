# Upload demo content
resource "aws_s3_object" "storage_bucket_demo_content" {
  bucket = aws_s3_bucket.storage_bucket.id
  key    = "kitty-01.jpeg"
  source = "${path.module}/content/kitty-01.jpeg"
  etag   = filemd5("${path.module}/content/kitty-01.jpeg")
}

# Upload index page
resource "aws_s3_object" "storage_bucket_index_content" {
  bucket = aws_s3_bucket.storage_bucket.id
  key    = "index.html"
  source = "${path.module}/content/index.html"
  etag   = filemd5("${path.module}/content/index.html")
}

# Upload 404 page
resource "aws_s3_object" "storage_bucket_404_content" {
  bucket = aws_s3_bucket.storage_bucket.id
  key    = "404.html"
  source = "${path.module}/content/404.html"
  etag   = filemd5("${path.module}/content/404.html")
}
