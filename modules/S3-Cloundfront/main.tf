# Création du bucket S3 pour les images
resource "aws_s3_bucket" "images" {
  bucket = var.bucket_name
  acl    = "private"
}

# Politique pour permettre à CloudFront d’accéder au bucket via une Origin Access Identity (OAI)
resource "aws_s3_bucket_policy" "images_policy" {
  bucket = aws_s3_bucket.images.id
  policy = data.aws_iam_policy_document.images_bucket_policy.json
}

data "aws_iam_policy_document" "images_bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.images.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.oai.iam_arn]
    }
  }
}

# Création de l’Origin Access Identity pour CloudFront
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI pour accéder au bucket S3 des images"
}

# Création de la distribution CloudFront
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Distribution CloudFront pour diffuser les images"
  default_root_object = "index.html" # à ajuster selon vos besoins

  origin {
    domain_name = aws_s3_bucket.images.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.images.id}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id       = "S3-${aws_s3_bucket.images.id}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# Upload des images depuis le dossier local vers le "dossier" dans S3
resource "aws_s3_object" "images" {
  for_each = fileset("./images", "*")

  bucket = aws_s3_bucket.images.bucket
  key    = "images/${each.value}"
  source = "images/${each.value}"

}

