module "vpc" {
  #source             = "..\\..\\..\\modules\\vpc\\"
  source             = "app.terraform.io/opsschool-ben/vpc/aws"
  version            = "1.0.1"
  vpc_name           = var.vpc_name
  cidr_size          = var.cidr_size
  availability_zones = var.availability_zones
}
