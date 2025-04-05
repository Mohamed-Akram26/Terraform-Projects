# 1. VPC
resource "VPC" "vpc1" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "akram-vpc"
        Managed_by = "terraform"   # used to show that its managed by terraform no manual modification allowed
    }
  
}
# 2. Internet Gateway
# 3. Public Subnet 1
# 4. Private Subnet 1
# 5. Public RT 1
# 6. Private RT 1
# 7. Public subnet 1 association
# 8. Private subnet 1 association
# 9. Security Group 1
# 10. EC2 - web1
# 11. EC2 - DB1
