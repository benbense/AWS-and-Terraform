variable "private_key_path" {
  default = "C:\\Keys\\Homework1.pem" 
}

variable "key_name" {
  default = "Homework1"
}

variable "instances_to_create" {
  default = 2
}

variable "t2-micro" {
  default = "t2.micro"
}

variable "cidr_size" {
  default = "10.0.0.0/16"
}