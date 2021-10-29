variable "private_key_path" {
  default = "C:\\Keys\\Homework1.pem" 
}

variable "key_name" {
  default = "Homework1"
}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64*"]
    }
}

variable "vpc_name" {
  description = "value"
  type = string
}

variable "instances_to_create" {
  description = "value"
  type = number
}

variable "instance_type" {
  type = string
}
