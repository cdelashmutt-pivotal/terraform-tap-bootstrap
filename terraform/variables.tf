variable "project_name" {
  type    = string
  default = "central"
}

variable "tanzunet_username" {
  type = string
}

variable "tanzunet_password" {
  type = string
  sensitive = true
}

variable "git_client_id" {
  type = string
  sensitive = true
}

variable "git_client_secret" {
  type = string
  sensitive = true
}

variable "gitops_repo_url" {
  type = string
  default = "https://github.com/cdelashmutt-pivotal/terraform-tap-bootstrap"
}

variable "gitops_repo_branch" {
  type = string
  default = "main"
}

variable "gitops_repo_subPath" {
  type = string
  default = "cluster"
}

variable "dns_parent_zone_rg" {
  type = string
  default = "dns"
}

variable "dns_parent_zone_name" {
  type = string
  default = "azure.grogscave.net"
}