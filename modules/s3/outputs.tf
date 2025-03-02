# Outputs
output "bucket_name" {
  description = "Le nom du bucket S3"
  value       = aws_s3_bucket.my_bucket.bucket
}

output "bucket_url" {
  description = "L'URL du bucket S3"
  value       = "https://${aws_s3_bucket.my_bucket.bucket}.s3.amazonaws.com"
}

output "object_key" {
  description = "Le nom de l'objet dans le bucket"
  value       = aws_s3_object.my_bucket_object.key
}

output "versioning_status" {
  description = "Statut de la gestion des versions du bucket"
  value       = aws_s3_bucket_versioning.my_bucket_versioning.versioning_configuration[0].status
}

output "bucket_id" {
  description = "L'ID unique du bucket"
  value       = aws_s3_bucket.my_bucket.id
}
