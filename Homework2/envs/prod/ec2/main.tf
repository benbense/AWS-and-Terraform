module "ec2" {
  source = "..\\..\\..\\modules\\ec2\\"
  vpc_name = var.vpc_name
  instances_to_create = var.instances_to_create
  instance_type = var.instance_type
}