variable "aws_region" {
  description = "La région AWS dans laquelle déployer les ressources"
  type        = string
  default     = "eu-west-3"
}

variable "bucket_name" {
  description = "Nom du bucket S3 qui contiendra les images"
  type        = string
  default     = "list-desserts-nextjs-port" #  
}
