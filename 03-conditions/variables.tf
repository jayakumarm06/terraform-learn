# variable "environement" {
#   default = "dev"

# }

variable "environement" {
  default = "prod"

}





variable "ami_id" {
  type        = string
  default     = "ami-0055977a6e828a4f4"
  description = "AMI ID of the instance"

}



variable "ec2_tags" {
  type = map(any)
  default = {
    Name        = "roboshop-mongodb"
    Environment = "dev"
    Terraform   = "true"
    Project     = "roboshop"
    Component   = "mongodb"

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
