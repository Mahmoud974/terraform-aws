variable "aws_region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-3"
}

variable "s3_bucket_name" {
  description = "Nom du bucket S3"
  type        = string
  default     = "prod-list-desserts"
}
