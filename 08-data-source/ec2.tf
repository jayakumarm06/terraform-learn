
resource "aws_instance" "data-source" {
  ami           = data.aws_ami.name.id
  instance_type = var.instance_type
  # Attach the security group by its resource ID reference
  vpc_security_group_ids = [aws_security_group.data-source.id]

  tags = {
    Name = "data-source-server"
  }
}


resource "aws_security_group" "data-source" {
  name        = "data-source-sg"
  description = "Allow TLs inbound traffic and all outbound traffic"


  # Ingress block inside the resource
  ingress {
    from_port   = var.from_port
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }

  # Egress block inside the resource
  egress {
    from_port   = var.from_port
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }

  tags = {
    Name = "data-source-sg"
  }
}
