# ========================
# Variables
# ========================

# AWS Region
variable "aws_region" {
  default = "us-east-1"
}

# Amazon Machine Image ID
variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
}

# EC2 Key Pair Name
variable "key_name" {
  description = "Your EC2 key pair"
}