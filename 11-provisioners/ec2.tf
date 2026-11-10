
resource "aws_instance" "provisioners" {
  ami           = var.ami_id
  instance_type = var.instance_type
  # Attach the security group by its resource ID reference
  vpc_security_group_ids = [aws_security_group.provisioners.id]


  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory.ini"
  }

  provisioner "local-exec" {
    command = "echo Instance created"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Intance is going to be destroyed"

  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  tags = {
    Name = "rooshop-provisioners"
  }
}


resource "aws_security_group" "provisioners" {
  name        = "provisioners-sg"
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
    Name = "provisioners-sg"
  }
}
