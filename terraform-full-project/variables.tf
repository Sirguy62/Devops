variable "aws_region" {
  description = "AWS region"
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Project name prefix for resources"
  default     = "edwin-project"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Ubuntu AMI ID for us-east-1"
  default     = "ami-0d4d7e98021b6b9a6"
}

variable "bucket_prefix" {
  description = "Prefix for S3 bucket"
  default     = "edwin-tf-bucket"
}

variable "key_pair_name" {
  description = "Existing AWS key pair name for EC2 SSH"
  default     = "first"
}
