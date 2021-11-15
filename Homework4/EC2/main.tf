data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "opsschool-ben"
    workspaces = {
      name = "VPC"
    }
  }
}
module "ec2" {
  #source               = "..\\..\\..\\modules\\ec2\\"
  source               = "benbense/ec2/aws"
  version              = "1.0.0"
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id
  available_zone_names = data.terraform_remote_state.vpc.outputs.available_zone_names
  public_subnets_ids   = data.terraform_remote_state.vpc.outputs.public_subnets_ids
  private_subnets_ids  = data.terraform_remote_state.vpc.outputs.private_subnets_ids
  instances_to_create  = var.instances_to_create
  instance_type        = var.instance_type
  bucket_name          = var.bucket_name
}
