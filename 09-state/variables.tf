

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
