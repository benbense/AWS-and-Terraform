variable "cidr_size" {
  description = "CIDR Size"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones to account for"
  type        = number
}
