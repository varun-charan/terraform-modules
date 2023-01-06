locals {
  module-name    = yamldecode(file("terraform.yaml"))["name"]
  module-version = yamldecode(file("terraform.yaml"))["version"]

  tags = {
    "heritage"       = "tfm/tg",
    "owner"          = var.owner
    "squad"          = var.owner
    "CostCenter"     = var.owner
    "env"            = var.env,
    "module-name"    = local.module-name
    "module-version" = local.module-version
  }
  comment = "Managed by TFM/TG (${local.module-name}-${local.module-version})"
}