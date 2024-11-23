provider "aws" {
  region = "us-east-1"
}
provider "tls" {
}

resource "aws_instance" "demo-server" {
  ami           = "ami-012967cc5a8c9f891"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.keypair.key_name
  security_groups = [aws_security_group.ssh_access.name]

  tags = {
    Name        = "demo-server"
    Environment = "test"
  }
}
resource "tls_private_key" "demo-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "keypair" {
  key_name   = "my_key"
  public_key = tls_private_key.demo-key.public_key_openssh
}
resource "local_file" "private_key_file" {
  filename        = "C:/Users/ranad/cicd/tweet-trend-new/terraform_code/my_key.pem"
  content         = tls_private_key.demo-key.private_key_pem
  file_permission = "0600" # Secure file permissions
}
resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"
  description = "Allow SSH access from anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
