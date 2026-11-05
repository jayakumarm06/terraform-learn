
resource "aws_instance" "web" {
  ami           = "ami-0055977a6e828a4f4"
  instance_type = "t3.micro"
  # Attach the security group by its resource ID reference
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
    Name = "web-server"
  }
}


resource "aws_security_group" "web" {
  name        = "web-sg"
  description = "Allow TLs inbound traffic and all outbound traffic"


  # Ingress block inside the resource
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress block inside the resource
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}
