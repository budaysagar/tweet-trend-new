provider "aws" {
  region = "us-east-1"
}
provider "tls" {
}

resource "aws_instance" "demo-server" {
  ami             = "ami-012967cc5a8c9f891"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  subnet_id       = aws_subnet.public_subnet.id

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
  filename        = "C:/Users/ranad/project2/tweet-trend-new/terraform_code/my_key.pem"
  content         = tls_private_key.demo-key.private_key_pem
  file_permission = "0600" # Secure file permissions
}
resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"
  description = "Allow SSH access from anywhere"
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_vpc" "demo-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Auto-assign public IPs

  tags = {
    Name = "demo-public-subnet"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-public-route-table"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demo_igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

