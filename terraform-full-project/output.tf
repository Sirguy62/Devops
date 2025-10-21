output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "ec2_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}

output "ec2_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.bucket
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
