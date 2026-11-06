resource "aws_route53_record" "roboshop" {
  #   count           = 10
  count           = length(var.instances)
  zone_id         = var.zone_id
  name            = "${var.instances[count.index]}.${var.domain_name}"
  type            = "A"
  ttl             = 1
  records         = [aws_instance.roboshop[count.index].private_ip]
  allow_overwrite = true
}

# Z0422560Y2KTB122939V


resource "aws_route53_record" "roboshop-frontend" {
  count           = contains(var.instances, "frontend") ? 1 : 0
  zone_id         = var.zone_id
  name            = var.domain_name
  type            = "A"
  ttl             = 1
  records         = [aws_instance.roboshop[index(var.instances, "frontend")].public_ip]
  allow_overwrite = true
}
