variable "bucket_name" {
  description = "Name of the bucket where the content is stored"
  type        = string
  default     = "content-bucket"
}

variable "tags" {
  description = "Tags to be applied to all created resources"
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
  }
}
