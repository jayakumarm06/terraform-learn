data "http" "myip" {
  url = "https://checkip.amazonaws.com/"

}

data "aws_vpc" "default" {
  default = true

}
locals {
  frontend_services = [
    "catalogue",
    "user",
    "cart",
    "shipping",
    "payment"
  ]
}

locals {
  my_ip = "${chomp(data.http.myip.response_body)}/32"
}



resource "aws_security_group" "services" {
  for_each = var.services

  name        = "${each.key}-terraform-sg"
  description = "${each.key} secuirty group"
  vpc_id      = data.aws_vpc.default.id


}

#SSH for all services
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each = aws_security_group.services


  security_group_id = each.value.id


  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ipv4   = local.my_ip
}

resource "aws_vpc_security_group_ingress_rule" "connections" {
  for_each = {
    for idx, conn in var.sg_connections : idx => conn
  }
  description                  = "${each.value.source} to ${each.value.destination}"
  security_group_id            = aws_security_group.services[each.value.destination].id
  referenced_security_group_id = aws_security_group.services[each.value.source].id

  ip_protocol = "tcp"
  from_port   = var.services[each.value.destination]
  to_port     = var.services[each.value.destination]
}
# for idx, conn in var.sg_connections : idx => conn

# is simply to convert a list into a map so it can be used with for_each.

# #fortend security group
resource "aws_security_group" "frontend" {
  name        = "frontend-terraform-sg"
  description = "frontend security group"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "frontend_http" {
  security_group_id = aws_security_group.frontend.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"

}

resource "aws_vpc_security_group_ingress_rule" "shh" {
  security_group_id = aws_security_group.frontend.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = local.my_ip

}

resource "aws_vpc_security_group_ingress_rule" "frontend_to_backend" {
  for_each                     = toset(local.frontend_services)
  description                  = "frontend to ${each.value}"
  security_group_id            = aws_security_group.services[each.value].id
  referenced_security_group_id = aws_security_group.frontend.id
  ip_protocol                  = "tcp"
  from_port                    = 8080
  to_port                      = 8080
}
