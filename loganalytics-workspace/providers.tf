terraform {
  required_version = ">= 1.0.11"

  required_providers {
    azurerm = "= 2.76.0"
    vault   = "~> 2.7"
  }
}

provider "azurerm" {
  features {}
}
