locals {
  distribution_https_url = format("http://%s", aws_cloudfront_distribution.storage_bucket_distribution.domain_name)
  kitty_https_url        = format("https://%s/kitty-01.jpeg", aws_cloudfront_distribution.storage_bucket_distribution.domain_name)
  url_expiration_date    = formatdate("YYYY-MM-DD", timeadd(timestamp(), "48h"))
}
