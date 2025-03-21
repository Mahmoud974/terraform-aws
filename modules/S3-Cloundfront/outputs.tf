output "s3_bucket_name" {
  description = "Nom du bucket S3"
  value       = aws_s3_bucket.images.id
}

output "cloudfront_distribution_domain" {
  description = "Domaine CloudFront"
  value       = aws_cloudfront_distribution.cdn.domain_name
}
