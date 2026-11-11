
resource "aws_instance" "tfvars_demo" {
  ami           = data.aws_ami.name.id
  instance_type = var.instance_type
  # Attach the security group by its resource ID reference
  vpc_security_group_ids = [aws_security_group.tfvars_demo.id]


  tags = merge(
    var.ec2_tags,
    {
      Environment = "${var.environment}"
    }
  )
}


resource "aws_security_group" "tfvars_demo" {
  name        = "tfvars_demo-${var.environment}-sg"
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
    Name = "tfvars_demo-${var.environment}"
  }
  lifecycle {
    create_before_destroy = true
  }
}
