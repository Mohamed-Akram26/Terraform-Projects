# Please refer to ARTIFACTS.md for screenshots and verification steps.

# Terraform Project: VPC Infrastructure on AWS

## Project Overview

This Terraform project creates a custom VPC (Virtual Private Cloud) on AWS from scratch. It includes both public and private subnets, route tables, an internet gateway, security groups, and two EC2 instances — one web server and one database server — each in different subnets.

---

## Features

- Custom VPC creation (`10.0.0.0/16`)
- One Public Subnet (`10.0.1.0/24`)
- One Private Subnet (`10.0.2.0/24`)
- Internet Gateway for external access
- Public and Private Route Tables with subnet associations
- Security Group for ingress and egress traffic
- EC2 instance in public subnet (`web1`)
- EC2 instance in private subnet (`db1`)
- Output for instance IPs

---

## Project Structure

- `provider.tf`: AWS provider configuration
- `variables.tf`: Variables used in the configuration
- `terraform.tfvars`: Values for declared variables
- `vpc.tf`: All infrastructure components (VPC, subnets, route tables, security groups, EC2 instances) `outputs`: Public and private IPs of the instances

---

## How to Run This Project

1. **Initialize Terraform**
   ```bash
   terraform init

2. **Review the execution plan**
   ```bash
   terraform plan

3. **Apply the configuration**
   ```bash
   terraform apply -auto-approve
