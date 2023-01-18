# Save private key
resource "local_file" "pem_file" {
  filename          = "${path.module}/test.pem"
  file_permission   = "600"
  sensitive_content = tls_private_key.signer_keypair.private_key_pem
}

# Generate the signed URL
resource "null_resource" "sign_url" {
  provisioner "local-exec" {
    command = format("aws cloudfront sign --url %s --key-pair-id %s --private-key %s --date-less-than %s",
      "",
      aws_cloudfront_public_key.storage_bucket_signers_key.id,
      "file://test.pem",
      "2023-12-12"
    )
  }
}
