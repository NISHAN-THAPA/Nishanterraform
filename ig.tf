resource "aws_internet_gateway" "nishan-ig01" {
}


resource "aws_internet_gateway_attachment" "igattach" {
  internet_gateway_id = aws_internet_gateway.nishan-ig01.id
  vpc_id              = aws_vpc.testvpc.id
}
