output "instances-info" {
  value = aws_instance.roboshop[0].private_ip

}
