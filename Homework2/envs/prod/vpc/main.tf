module "vpc" {
  source             = "..\\..\\..\\modules\\vpc\\"
  vpc_name           = var.vpc_name
  cidr_size          = var.cidr_size
  availability_zones = 2
}

module "ec2" {
  source               = "..\\..\\..\\modules\\ec2\\"
  vpc_id               = module.vpc.vpc_id
  available_zone_names = module.vpc.available_zone_names
  public_subnets_ids   = module.vpc.public_subnets_ids
  private_subnets_ids  = module.vpc.private_subnets_ids
  instances_to_create  = var.instances_to_create
  instance_type        = var.instance_type
  bucket_name          = var.bucket_name
}
