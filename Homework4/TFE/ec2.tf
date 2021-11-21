resource "tfe_workspace" "ec2" {
  name         = "EC2"
  organization = var.tfc_organization_name
  vcs_repo {
    identifier     = "${var.github_user}/AWS-and-Terraform"
    oauth_token_id = tfe_oauth_client.github.oauth_token_id
    branch         = var.github_branch
  }
  auto_apply          = var.auto_apply
  global_remote_state = true
  execution_mode      = "remote"
  working_directory   = "/Homework4/EC2"
}

resource "tfe_run_trigger" "vpc_creation" {
  workspace_id  = tfe_workspace.ec2.id
  sourceable_id = tfe_workspace.vpc.id
}

resource "tfe_oauth_client" "github" {
  organization     = var.tfe_organization_name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  service_provider = "github"
  oauth_token      = var.oauth_token
}