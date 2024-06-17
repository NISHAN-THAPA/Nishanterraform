# Define the VPC
resource "aws_vpc" "testvpc" {
  cidr_block = "10.3.0.0/16"
  tags = {
    Name = "nishan" 
  }
}

# Define the EC2 instances
resource "aws_instance" "nishanhttpd" {
  ami = "ami-0df032b0fbc220383"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.nishansubnet.id
  vpc_security_group_ids = [aws_security_group.nishansg.id]
 tags = {
    Name = "nishanhttpd"
  }
  key_name = "NISHAN"
}

