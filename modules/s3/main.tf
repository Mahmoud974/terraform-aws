provider "aws" {
  region = "eu-west-3"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "kokook-camelias-moussa-moussa-go"

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
resource "aws_s3_object" "my_bucket_object" {
  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "img.png"                                                # Nom du fichier dans le bucket
  source = "/Users/moussa/Desktop/terraform-aws/modules/s3/main.tf" # Chemin vers le fichier local que vous voulez télécharger
  acl    = "private"                                                # Par défaut, l'accès au fichier est privé
}

