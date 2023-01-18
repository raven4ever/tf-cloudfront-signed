variable "s3_bucket_name" {
  description = "Name of the bucket where the content is stored"
  type        = string
  default     = "000-super-important-content-999"
}

variable "time_for_url_expire" {
  description = "Amount of time to be added from current timestamp until the signed URL will expire"
  default     = "48h"
}

variable "date_format" {
  description = "Date format for URL sign process"
  default     = "DD-MM-YYYY"
}

variable "tags" {
  description = "Tags to be applied to all created resources"
  type        = map(string)
  default = {
    CreatedBy = "Terraform"
  }
}
