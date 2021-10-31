variable "private_key_path" {
  default = "C:\\Keys\\Homework1.pem"
}

variable "key_name" {
  default = "Homework1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64*"]
  }
}

variable "instances_to_create" {
  description = "EC2 Instances to create"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
}

variable "private_subnets_ids" {
  description = "List of private subnets ids"
  type        = list(string)
}

variable "public_subnets_ids" {
  description = "List of public subnets ids"
  type        = list(string)
}

variable "available_zone_names" {
  description = "List of avilabale AZ's"
  type        = list(string)
}

variable "bucket_name" {
  description = "S3 Bucket name for logs"
  type        = string
}
