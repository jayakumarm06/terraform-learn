
resource "aws_instance" "roboshop" {
  for_each      = var.instances
  ami           = var.ami_id
  instance_type = each.value.instance_type
  # Attach the security group by its resource ID reference
  vpc_security_group_ids = [
    aws_security_group.common.id,
    aws_security_group.roboshop[each.key].id
  ]

  tags = {
    Name = "${var.project}-${var.environement}-${each.key}"
  }
}


resource "aws_security_group" "common" {
  name        = "${var.project}-${var.environement}-common"
  description = "A common SG for all the instances  of roboshop"


  # Egress block inside the resource
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-${var.environement}-common"
  }
}


resource "aws_security_group" "roboshop" {
  for_each    = var.instances
  name        = "${var.project}-${var.environement}-${each.key}"
  description = "A component SG for all the instances  of roboshop"

  # Ingress block inside the resource
  ingress {
    from_port   = each.value.port_no
    to_port     = each.value.port_no
    protocol    = "tcp"
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
    Name = "${var.project}-${var.environement}-${each.key}"
  }
}
