terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "5.9.0"
        }
    }
    required_version = "1.14.8"
    backend "azurerm" {
        storage_account_name = "rahman2027"
        resource_group_name = "state"
        container_name = "terraform-state"
        key = "terraform.tfstate"
    }
}

provider "azurerm" {
    features {}
}