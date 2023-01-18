output "storage_bucket" {
  description = "Storage Bucket regional domain name"
  value       = aws_s3_bucket.storage_bucket.bucket_regional_domain_name
}

output "distribution_url" {
  description = "URL to access the CloudFront distribution"
  value       = local.distribution_https_url
}

output "kitty_url" {
  description = "URL to access the kitty JPEG"
  value       = local.kitty_https_url
}

output "signed_kitty_url" {
  description = "Signed URL to access the kitty JPEG"
  value       = data.external.sign_kitty_url.result.url
}
