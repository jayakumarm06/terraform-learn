variable "ami_id" {
  type        = string
  default     = "ami-0055977a6e828a4f4"
  description = "AMI ID of the instance"

}
variable "instance_type" {
  type = string

}

variable "environment" {
  type = string

}



variable "ec2_tags" {

  type = map(string)
  default = {
    Name      = "roboshop-tfvars-demo"
    Terraform = "true"
    Project   = "roboshop"
  }

}


variable "cidr" {
  type    = list(any)
  default = ["0.0.0.0/0"]

}

variable "from_port" {
  type    = number
  default = 0
}
