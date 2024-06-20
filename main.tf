terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Define the provider
provider "aws" {
  region = "sa-east-1"
}

# Define the security group
resource "aws_security_group" "nishansg" {
  name_prefix = "nishansg"
   vpc_id = aws_vpc.testvpc.id

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

egress {   
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

# Define the VPC
resource "aws_vpc" "testvpc" {
  cidr_block = "10.3.0.0/16"
  tags = {
    Name = "nishan" 
  }
}

# Define the EC2 instances
resource "aws_instance" "nishanhttpd" {
  ami = var.ami
  instance_type = "t2.micro"
  subnet_id = aws_subnet.nishansubnet.id
  vpc_security_group_ids = [aws_security_group.nishansg.id]
 tags = {
    Name = "nishanhttpd"
  }
  key_name = "NISHAN"
user_data = <<-EOF
#!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div><h1>Hello, world!</h1></div></body></html>" > /var/www/html/index.html
    EOF
}



# Define the subnets
resource "aws_subnet" "nishansubnet" {
  vpc_id = aws_vpc.testvpc.id
  cidr_block = "10.3.1.0/24"
  availability_zone = "sa-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "nishansubnet"
  }

}


resource "aws_route_table" "routetb01" {
vpc_id              = aws_vpc.testvpc.id
}

resource "aws_route" "route01" {
  route_table_id            = aws_route_table.routetb01.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.nishan-ig01.id
}


resource "aws_route_table_association" "routetbassoc01" {
  subnet_id      = aws_subnet.nishansubnet.id
  route_table_id = aws_route_table.routetb01.id
}

resource "aws_internet_gateway" "nishan-ig01" {
}


resource "aws_internet_gateway_attachment" "igattach" {
  internet_gateway_id = aws_internet_gateway.nishan-ig01.id
  vpc_id              = aws_vpc.testvpc.id

}


