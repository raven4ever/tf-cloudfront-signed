output "storage_bucket" {
  description = "Storage Bucket regional domain name"
  value       = aws_s3_bucket.storage_bucket.bucket_regional_domain_name
}

output "storage_bucket_distribution" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.storage_bucket_distribution.domain_name
}
