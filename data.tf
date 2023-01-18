data "aws_iam_policy_document" "storage_bucket_policy_document" {
  statement {
    sid       = "AllowOAIAccessToBucketObjects"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.storage_bucket.arn}/*"]
    actions   = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.storage_bucket_oai.iam_arn]
    }
  }
}
