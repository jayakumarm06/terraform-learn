
resource "aws_instance" "workspaces-demo" {
  ami           = data.aws_ami.name.id
  instance_type = lookup(var.instance_type, terraform.workspace)
  # Attach the security group by its resource ID reference
  vpc_security_group_ids = [aws_security_group.workspaces-demo.id]


  tags = var.ec2_tags
}


resource "aws_security_group" "workspaces-demo" {
  name        = "workspaces-demo-${terraform.workspace}-sg"
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
    Name = "workspaces-demo-${terraform.workspace}"
  }
  lifecycle {
    create_before_destroy = true
  }
}
