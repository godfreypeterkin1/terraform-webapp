# terraform-webapp
Encompasses All
This project sets up a secure, scalable, and cost-efficient web application architecture using **Terraform** and **AWS Free Tier** services. It includes IAM, VPC, EC2, ALB, Auto Scaling, RDS, and more — designed to showcase your cloud architecture and infrastructure-as-code (IaC) skills.

---

## 🧱 Architecture Overview

- **VPC** with public/private subnets across 2 AZs
- **EC2** instances in private subnets (via Auto Scaling Group)
- **Application Load Balancer (ALB)** in public subnet
- **RDS** (MySQL/PostgreSQL) in private subnet with encryption
- **IAM** users, roles, and policies with least privilege
- **Security Groups** and **NACLs** for traffic control
- **Bastion Host** for secure SSH (optional)
- **CloudWatch Logs** and **SNS** alerts

---

## 🌐 Use Cases

- Demonstrate knowledge of secure AWS architectures
- Prepare for the AWS Solutions Architect Associate exam
- Showcase Terraform IaC skills for interviews
- Launch personal/prototype web apps cost-effectively

---

## ⚙️ Tech Stack

- **Terraform 1.x**
- **AWS Free Tier**
- **Amazon Linux 2 AMI**
- **MySQL/PostgreSQL RDS**
- **ACM for HTTPS/SSL (optional)**

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/terraform-webapp.git
cd terraform-webapp
