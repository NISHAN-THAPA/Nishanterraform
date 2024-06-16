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
