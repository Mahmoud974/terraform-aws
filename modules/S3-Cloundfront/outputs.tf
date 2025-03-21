output "s3_bucket_name" {
  description = "Nom du bucket S3 créé"
  value       = aws_s3_bucket.images.id
}

output "cloudfront_domain_name" {
  description = "Nom de domaine de la distribution CloudFront"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

# Output pour afficher l'URL CloudFront
output "cloudfront_url" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

# Output pour afficher la clé de l'objet S3
output "s3_object_key" {
  value = "images/"
}
