data "aws_iam_policy_document" "storage_bucket_policy_document" {
#   statement {
#     sid       = "AllowPublicGetToBucketObjects"
#     effect    = "Allow"
#     resources = ["${aws_s3_bucket.storage_bucket.arn}/*"]
#     actions   = ["s3:GetObject"]
#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }
#   }
  statement {
    sid       = "AllowOAIAccessToBucketObjects"
    effect    = "Allow"
    resources = ["${aws_s3_bucket.storage_bucket.arn}/*"]
    actions   = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_distribution.storage_bucket_distribution.arn]
    }
  }
}
