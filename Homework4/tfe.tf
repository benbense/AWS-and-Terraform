resource "tfe_workspace" "tfe" {
  name         = "TFE"
  organization = var.tfe_organization_name
  vcs_repo {
    identifier     = "${var.github_user}/AWS-and-Terraform"
    oauth_token_id = tfe_variable.github_oauth_token
    branch         = var.github_branch
  }
  execution_mode      = "remote"
  global_remote_state = true
  working_directory   = "/Homework4/TFE"
}

resource "tfe_oauth_client" "github" {
  organization     = var.tfe_organization_name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  service_provider = "github"
  oauth_token      = var.github_pat
}

resource "tfe_variable" "github_oauth_token" {
  key          = "github_oauth_token"
  value        = tfe_oauth_client.github.oauth_token_id
  description  = "Generated Github OAuth Token"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
  sensitive    = true
}

resource "tfe_variable" "tfe_organization_name" {
  key          = "tfe_organization_name"
  value        = var.tfe_organization_name
  description  = "Organization Name"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
}

resource "tfe_variable" "github_user" {
  key          = "github_user"
  value        = var.github_user
  description  = "Github Username"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
}

resource "tfe_variable" "github_pat" {
  key          = "github_pat"
  value        = var.github_pat
  description  = "Github Personal Acess Token"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
  sensitive    = true
}

resource "tfe_variable" "tfe_token" {
  key          = "TFE_TOKEN"
  value        = ""
  description  = "Terraform Cloud API Token"
  category     = "env"
  workspace_id = tfe_workspace.tfe.id
  sensitive    = true
}

resource "tfe_variable" "github_branch" {
  key          = "github_branch"
  value        = var.github_branch
  description  = "Github Branch Name (Default is main)"
  category     = "terraform"
  workspace_id = tfe_workspace.tfe.id
}
