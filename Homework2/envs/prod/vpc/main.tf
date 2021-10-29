module "vpc" {
  source = "..\\..\\..\\modules\\vpc\\"
  vpc_name = var.vpc_name
  cidr_size = var.cidr_size
  availability_zones = 2
}
