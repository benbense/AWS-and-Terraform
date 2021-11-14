module "vpc" {
  #source             = "..\\..\\..\\modules\\vpc\\"
  source             = "benbense/ec2/aws"
  version            = "1.0.0"
  vpc_name           = var.vpc_name
  cidr_size          = var.cidr_size
  availability_zones = var.availability_zones
}

module "ec2" {
  #source               = "..\\..\\..\\modules\\ec2\\"
  source               = "benbense/ec2/aws"
  version              = "1.0.0"
  vpc_id               = module.vpc.vpc_id
  available_zone_names = module.vpc.available_zone_names
  public_subnets_ids   = module.vpc.public_subnets_ids
  private_subnets_ids  = module.vpc.private_subnets_ids
  instances_to_create  = var.instances_to_create
  instance_type        = var.instance_type
  bucket_name          = var.bucket_name
}
