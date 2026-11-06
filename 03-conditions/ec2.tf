
resource "aws_instance" "conditions" {
  ami                    = var.ami_id
  instance_type          = var.environement == "dev" ? "t3.micro" : "t3.medium"
  vpc_security_group_ids = [aws_security_group.conditions.id]

  tags = {
    Name = "roboshop-condition"
  }
}

resource "aws_security_group" "conditions" {
  name        = "conditions"
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-condition"
  }
}
