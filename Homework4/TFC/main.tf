module "vpc" {
  source                    = "app.terraform.io/opsschool-ben/vpc/tfe"
  version                   = "1.0.9"
  tfe_organization_name     = var.tfe_organization_name
  github_user               = var.github_user
  oauth_token_id            = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch             = var.github_branch
  availability_zones        = var.availability_zones
  vpc_name                  = var.vpc_name
  aws_acess_key             = var.aws_acess_key
  aws_secret_acess_key      = var.aws_secret_acess_key
  aws_default_region        = var.aws_default_region
  cidr_size                 = var.cidr_size
  vpc_workspace_name        = var.vpc_workspace_name
  workspace_repo_identifier = var.workspace_repo_identifier
  vpc_workspace_directory   = var.vpc_workspace_directory
}

module "ec2" {
  source                    = "app.terraform.io/opsschool-ben/ec2/tfe"
  version                   = "1.0.8"
  tfe_organization_name     = var.tfe_organization_name
  github_user               = var.github_user
  oauth_token_id            = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch             = var.github_branch
  aws_acess_key             = var.aws_acess_key
  aws_default_region        = var.aws_default_region
  aws_secret_acess_key      = var.aws_secret_acess_key
  bucket_name               = var.bucket_name
  instance_type             = var.instance_type
  instances_to_create       = var.instances_to_create
  ec2_workspace_name        = var.ec2_workspace_name
  vpc_workspace_name        = var.vpc_workspace_name
  workspace_repo_identifier = var.workspace_repo_identifier
  ec2_workspace_directory   = var.ec2_workspace_directory
  depends_on = [
    module.vpc
  ]
}

resource "tfe_run_trigger" "vpc_creation" {
  workspace_id  = module.ec2.ec2_workspace_id
  sourceable_id = module.vpc.vpc_workspace_id
}
