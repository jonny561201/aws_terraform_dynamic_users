variable "region" {
  type = string
  default = "us-east-1"
}

variable "deploy_env" {
  type = string
  default = "prod"
}

variable "user_count" {}

module "classroom_user_deploy_prod" {
  source = "../common"

  region = var.region
  deploy_env = var.deploy_env
  user_count = var.user_count
}