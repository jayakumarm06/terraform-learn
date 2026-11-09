resource "aws_security_group" "dynamic" {
  name        = "dynamic-sg"
  description = "Allow TLs inbound traffic and all outbound traffic"


  # Ingress block inside the resource
  dynamic "ingress" { #terrafomr will give block name as special variable
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks

    }

  }

  # Egress block inside the resource
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dynamic-sg"
  }
}
