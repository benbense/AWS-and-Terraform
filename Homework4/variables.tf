variable "tfe_organization_name" {
  type        = string
  description = "Terraform Cloud Organization Name"
}

variable "github_user" {
  type        = string
  description = "Github Username"
}

variable "github_pat" {
  type        = string
  description = "Github OAuth Token"
}

variable "tfe_token" {
  type        = string
  description = "Terraform Cloud API Token"
}

variable "github_branch" {
  type        = string
  description = "Github Branch Name (Default is main)"
}
