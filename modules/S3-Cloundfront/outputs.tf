output "s3_bucket_name" {
  description = "Nom du bucket S3 créé"
  value       = aws_s3_bucket.images.bucket
}

output "cloudfront_domain_name" {
  description = "Nom de domaine de la distribution CloudFront"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

# Output pour générer l'URL de CloudFront pour chaque image
output "cloudfront_image_urls" {
  value = [for image in aws_s3_object.images : "https://${aws_cloudfront_distribution.cdn.domain_name}/images/${image.key}"]
}
