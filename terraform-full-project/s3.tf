resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "edwin-tf-bucket-${random_id.suffix.hex}"
  acl    = "private"

  tags = {
    Name = "${var.project_name}-bucket"
  }
}
