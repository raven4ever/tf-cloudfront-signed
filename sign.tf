# Save private key
resource "local_sensitive_file" "private_key_file" {
  content         = tls_private_key.signer_keypair.private_key_pem
  filename        = "${path.module}/test.pem"
  file_permission = "600"
}

data "external" "sign_kitty_url" {
  program = ["/bin/bash", "sign.sh"]

  query = {
    url : local.kitty_https_url
    key-pair-id : aws_cloudfront_public_key.storage_bucket_signers_key.id
    private-key : "file://test.pem"
    end-date : local.url_expiration_date
  }
}
