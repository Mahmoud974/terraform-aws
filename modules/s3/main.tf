provider "aws" {
  region = "eu-west-3"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "royal-valence-db-csv"
}

# Blocage de l'accès public pour le bucket
resource "aws_s3_bucket_public_access_block" "my_bucket_access_block" {
  bucket = aws_s3_bucket.my_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Gestion des versions du bucket
resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

# Télécharger un fichier vers le bucket S3
# resource "aws_s3_object" "my_bucket_object" {
#   bucket = aws_s3_bucket.my_bucket.bucket
#   key    = "lambda-nodejs.zip"
#   source = "/Users/moussa/Desktop/terraform-aws/modules/s3/main.tf"
#   acl    = "private"
# }
