module "vpc" {
  source                = "app.terraform.io/opsschool-ben/vpc/tfe"
  version               = "1.0.5"
  tfe_organization_name = var.tfe_organization_name
  github_user           = var.github_user
  oauth_token_id        = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch         = var.github_branch
  availability_zones    = var.availability_zones
  vpc_name              = var.vpc_name
  aws_acess_key         = var.aws_acess_key
  aws_secret_acess_key  = var.aws_secret_acess_key
  aws_default_region    = var.aws_default_region
  cidr_size             = var.cidr_size
  vpc_workspace_name    = var.vpc_workspace_name
}

module "ec2" {
  source                = "app.terraform.io/opsschool-ben/ec2/tfe"
  version               = "1.0.3"
  tfe_organization_name = var.tfe_organization_name
  github_user           = var.github_user
  oauth_token_id        = tfe_oauth_client.github_oauth.oauth_token_id
  github_branch         = var.github_branch
  aws_acess_key         = var.aws_acess_key
  aws_default_region    = var.aws_default_region
  aws_secret_acess_key  = var.aws_secret_acess_key
  bucket_name           = var.bucket_name
  instance_type         = var.instance_type
  instances_to_create   = var.instances_to_create
  ec2_workspace_name    = var.ec2_workspace_name
  vpc_workspace_name    = var.vpc_workspace_name
  depends_on = [
    module.vpc
  ]
}

resource "tfe_run_trigger" "vpc_creation" {
  workspace_id  = module.ec2.ec2_workspace_id
  sourceable_id = module.vpc.vpc_workspace_id
}

data "tfe_workspace_ids" "all" {
  names        = ["*"]
  organization = var.tfe_organization_name
}

resource "tfe_notification_configuration" "ec2_slack_notifications" {
  workspace_id     = module.ec2.ec2_workspace_id
  name             = var.ec2_workspace_name
  enabled          = true
  destination_type = "slack"
  triggers = [
    "run:created",
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored"
  ]
  url = var.slack_webhook_url
}
resource "tfe_notification_configuration" "vpc_slack_notifications" {
  workspace_id     = module.vpc.vpc_workspace_id
  name             = var.vpc_workspace_name
  enabled          = true
  destination_type = "slack"
  triggers = [
    "run:created",
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored"
  ]
  url = var.slack_webhook_url
}

# Notifications by iteration (Not working for some reason)
# resource "tfe_notification_configuration" "webhook" {
#   count            = length(data.tfe_workspace_ids.all.ids)
#   workspace_id     = values(data.tfe_workspace_ids.all.ids)[count.index]
#   name             = keys(data.tfe_workspace_ids.all.ids)[count.index]
#   enabled          = true
#   destination_type = "slack"
#   triggers = [
#     "run:created",
#     "run:planning",
#     "run:needs_attention",
#     "run:applying",
#     "run:completed",
#     "run:errored"
#   ]
#   url = var.slack_webhook_url
# }
