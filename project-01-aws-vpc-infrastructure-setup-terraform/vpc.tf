#1. VPC
resource "aws_vpc" "vpc1" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "${var.client_name}-vpc"
      managed_by = "${var.managed_by}"  # used to show that the resource was configured and managed by terraform no manual modification allowed
    }
  
}
# 2. Internet Gateway
resource "aws_internet_gateway" "igw1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name = "${var.client_name}-igw1"
      managed_by = "${var.managed_by}"
    }
}
# 3. Public Subnet 1
resource "aws_subnet" "pub_subnet1" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.1.0/24"
    tags = {
      Name = "${var.client_name}-pub_subnet1"
      managed_by = "${var.managed_by}"
    }
  
}
# 4. Private Subnet 1
resource "aws_subnet" "pri_subnet1" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = "10.0.2.0/24"
    tags = {
      Name = "${var.client_name}-pri_subnet1"
      managed_by = "${var.managed_by}"
    }
}
# 5. Public RT 1
resource "aws_route_table" "pub_rt1" {
    vpc_id = aws_vpc.vpc1.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw1.id
    }
    tags = {
      Name = "${var.client_name}-pub_rt1"
      managed_by = "${var.managed_by}"
    }
  
}
# 6. Private RT 1
resource "aws_route_table" "pri_rt1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name = "${var.client_name}-pri_rt1"
      managed_by = "${var.managed_by}"
    } 
}
# 7. Public subnet 1 association
resource "aws_route_table_association" "pubsub1_rt1" {
  subnet_id = aws_subnet.pub_subnet1.id
  route_table_id = aws_route_table.pub_rt1.id
}
# 8. Private subnet 1 association
resource "aws_route_table_association" "prisub1_rt1" {
  subnet_id = aws_subnet.pri_subnet1.id
  route_table_id = aws_route_table.pri_rt1.id
}
# 9. Security Group 1
resource "aws_security_group" "sg1" {
  name = "${var.client_name}-sg1"
  vpc_id = aws_vpc.vpc1.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["192.168.121.198/32", aws_vpc.vpc1.cidr_block]
    #ipv6_cidr_blocks =  
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks =  
  }
  tags = {
      Name = "${var.client_name}-sg1"
      managed_by = "${var.managed_by}"
  }
  
}
# 10. EC2  -  web1
resource "aws_instance" "web1" {
  ami             = "ami-08b5b3a93ed654d19"  # Change this based on region
  instance_type   = var.instance_type
  subnet_id = aws_subnet.pub_subnet1.id
  key_name        = "login"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg1.id]
  tags = {
      Name = "${var.client_name}-web1"
      managed_by = "${var.managed_by}"
  }
  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    systemctl enable nginx
    systemctl start nginx
  EOF
}
# 11. EC2 -  DB1
resource "aws_instance" "DB1" {
  ami             = "ami-08b5b3a93ed654d19"  # Change this based on region
  instance_type   = var.instance_type
  subnet_id = aws_subnet.pri_subnet1.id
  key_name        = "login"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg1.id]
  tags = {
      Name = "${var.client_name}-DB1"
      managed_by = "${var.managed_by}"
  }
}
