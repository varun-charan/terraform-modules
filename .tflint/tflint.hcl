config {
  format = "compact"
  plugin_dir = "./.tflint.d/plugins"

  module = true
  force = false
  disabled_by_default = false

  ignore_module = {
  }

#   varfile = [".ci/tfplan.tfvars"]
}

###   T F L I N T   R U L E S   ###
# Disallow terraform declarations without required_version.
rule "terraform_required_version" {
  enabled = true
}

# Require that all providers have version constraints through required_providers.
rule "terraform_required_providers" {
  enabled = true
}

###   T F L I N T   P L U G I N S  ###
plugin "aws" {
  enabled = true
  version = "0.21.1"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "azurerm" {
  enabled = true
  version = "0.20.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}