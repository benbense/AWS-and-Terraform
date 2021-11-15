variable "instances_to_create" {
  description = "EC2 instances to create"
  default     = 2
}

variable "instance_type" {
  description = "EC2 instances type"
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "Bucket name for ALB logs"
  default     = "ben-opsschool"
}
