# ========================
# Provider Configuration
# ========================
provider "aws" {
  region = var.aws_region
}

# ========================
# VPC Setup
# ========================
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "webapp-vpc"
  }
}

# ========================
# Internet Gateway for Public Subnet
# ========================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# ========================
# Public Subnet
# ========================
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = { Name = "public-subnet-1" }
}

# ========================
# Private Subnet
# ========================
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}a"
  tags = { Name = "private-subnet-1" }
}

# ========================
# Route Table for Public Subnet
# ========================
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# ========================
# Associate Public Subnet with Route Table
# ========================
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}

# ========================
# Security Group for Web Server
# ========================
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ========================
# EC2 Instance in Public Subnet
# ========================
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_1.id
  security_groups = [aws_security_group.web_sg.name]
  key_name      = var.key_name

  # Launch script
  user_data = file("userdata.sh")

  tags = {
    Name = "WebServer"
  }
}