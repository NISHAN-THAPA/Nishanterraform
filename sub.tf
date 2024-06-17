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

