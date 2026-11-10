
resource "aws_instance" "state-demo" {
  ami           = data.aws_ami.name.id
  instance_type = var.instance_type
  # Attach the security group by its resource ID reference
  vpc_security_group_ids = [aws_security_group.state-demo.id]

  tags = {
    Name = "state-demo-server"
  }
}


resource "aws_security_group" "state-demo" {
  name        = "state123-demo-sg"
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
    Name = "state-demo-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}
