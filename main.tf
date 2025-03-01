provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "mon_bucket" {
  bucket = "mon-bucket-terraform-demo"
}

