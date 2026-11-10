
resource "aws_instance" "locals-demo" {
  ami           = var.ami_id
  instance_type = local.instance_type
  # Attach the security group by its resource ID reference
  vpc_security_group_ids = [aws_security_group.locals-demo.id]

  tags = local.ec2_tags
}


resource "aws_security_group" "locals-demo" {
  name        = "locals-demo-sg"
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
    Name = "locals-demo-sg"
  }
}
