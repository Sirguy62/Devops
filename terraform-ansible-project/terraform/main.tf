resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Get your default VPC (needed for eu-north-1)
data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "web_ansible" {
  ami           = "ami-0d4d7e98021b6b9a6"
  instance_type = "t3.micro"
  key_name      = "first"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  tags = {
    Name = "Terraform-Ansible-Web"
  }

  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ../ansible
      echo "[web]" > ../ansible/hosts.ini
      echo "${self.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/first.pem" >> ../ansible/hosts.ini
    EOT
  }
}

output "public_ip" {
  value = aws_instance.web_ansible.public_ip
}

