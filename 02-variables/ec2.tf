
resource "aws_instance" "mongodb" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.mongodb.id]

  tags = var.ec2_tags
}


resource "aws_security_group" "mongodb" {
  name        = "mongodb-sg"
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
    Name = "roboshop-mongodb"
  }
}
