locals {
  module-name    = yamldecode(file("terraform.yaml"))["name"]
  module-version = yamldecode(file("terraform.yaml"))["version"]

  tf_tags = {
    "heritage"       = "tfm/tg",
    "owner"          = var.team_name,
    "squad"          = var.team_name,
    "env"            = var.env,
    "module-name"    = local.module-name
    "module-version" = local.module-version
  }
}
