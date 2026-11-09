resource "aws_route53_record" "roboshop" {
  for_each        = aws_instance.roboshop #ec2 output will become input of r53
  zone_id         = var.zone_id
  name            = "${each.key}.${var.domain_name}"
  type            = "A"
  ttl             = 1
  records         = [each.value.private_ip]
  allow_overwrite = true
}

# Z0422560Y2KTB122939V


resource "aws_route53_record" "roboshop-frontend" {
  # count           = contains(var.instances, "frontend") ? 1 : 0
  count           = contains(keys(var.instances), "frontend") ? 1 : 0
  zone_id         = var.zone_id
  name            = var.domain_name
  type            = "A"
  ttl             = 1
  records         = [lookup(aws_instance.roboshop, "frontend").public_ip]
  allow_overwrite = true
}
