terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.5.0"
    }

    ansible = {
      version = ">= 1.1.0"
      source  = "ansible/ansible"
    }

  }
}

provider "azurerm" {
  features {}
}

provider "ansible" {
}