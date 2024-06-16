# Define the VPC
resource "aws_vpc" "testvpc" {
  cidr_block = "10.3.0.0/16"
  tags = {
    Name = "nishan" 
  }
}
