# variable "cidr_size" {
#   description = "value"
#   default = "10.0.0.0/16"
# }

variable "t2-micro" {
  default = "t2.micro"
}

variable "vpc_name" {
  description = "value"
  default = "Test_VPC"
}

variable "instances_to_create" {
  description = "value"
  default = 2
}

variable "instance_type" {
  description = "value"
  default = "t2.micro"
}