config {
  format = "compact"
  plugin_dir = "./.tflint.d/plugins"

  module = true
  force = false
  disabled_by_default = false

  ignore_module = {
  }

  # varfile = ["example1.tfvars", "example2.tfvars"]
  # variables = ["foo=bar", "bar=[\"baz\"]"]
}

# Disallow terraform declarations without require_version.
rule "terraform_required_version" {
  enabled = true
}

# Require that all providers have version constraints through required_providers.
rule "terraform_required_providers" {
  enabled = true
}

plugin "aws" {
  enabled = true
  version = "0.21.1"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "azure" {
  enabled = true
  version = "0.19.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

rule "aws_instance_invalid_type" {
  enabled = false
}