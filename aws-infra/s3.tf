resource "aws_s3_bucket" "s3_boundary" {
  bucket = var.bucket_name

  tags = {
    Name        = "Boundary - Session Record"
  }
}