variable "ami_id" {
  type        = string
  default     = "ami-0055977a6e828a4f4"
  description = "AMI ID of the instance"

}

variable "instance_type" {
  type = map(string)
  default = {
    dev  = "t3.micro"
    prod = "t3.micro" #t3.medium
    uat  = "t3.micro" # t3.small
  }
}



variable "ec2_tags" {

  type = map(string)
  default = {
    Name        = "roboshop-workspace-demo"
    Environment = "dev"
    Terraform   = "true"
    Project     = "roboshop"
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
