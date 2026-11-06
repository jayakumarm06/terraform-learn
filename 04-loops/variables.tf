variable "environement" {
  default = "dev"

}

variable "project" {
  default = "roboshop"

}


variable "ami_id" {
  type        = string
  default     = "ami-0055977a6e828a4f4"
  description = "AMI ID of the instance"

}


variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type of EC2"

  validation {
    # The condition must var.environemtn_type to true for the input to be accepted
    condition     = contains(["t3.micro", "t3.small", "t3.medium", "t3.large"], var.instance_type)
    error_message = "instance type mmust be one of t3.small,t3.micro..."
  }

}


variable "instances" {
  type    = list(any)
  default = ["mongodb", "redis", "mysql", "rabbitmq", "catalogue", "user", "cart", "shipping", "payment", "frontend"]
}


variable "zone_id" {
  default = "Z0422560Y2KTB122939V"

}

variable "domain_name" {
  default = "dewsecopai.online"

}
