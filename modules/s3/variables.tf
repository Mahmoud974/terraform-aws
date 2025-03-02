variable "aws_region" {
  description = "La région AWS où le bucket S3 sera créé"
  default     = "eu-west-"
}

variable "bucket_name" {
  description = "Le nom du bucket S3"
  type        = string
}

variable "bucket_acl" {
  description = "Le niveau d'accès du bucket S3 (par exemple, private, public-read)"
  default     = "private"
}
