terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}
provider "aws" {
    region = ""
    access_key = ""
    secret_key = ""
}

 resource "aws_s3_bucket" "bucket" {
  bucket = "actualone-lti"

  tags = {
    Name        = "test bucket"
   
  }
}


resource "aws_s3_bucket_acl" "acl" {
 
  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"

}
 
resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key    = "file.txt"
  source = "/f/WEB PROJECTS/Terraform_LTI/s3_bucket/file.txt"
  content_type = "text/plain"
  acl    = "public-read"
 
}