provider "azurerm" {
  # Configuration options
  features {
    
  }
}

provider "random" {
  # Configuration options
}

resource "azurerm_resource_group" "rg" {
  name     = "TFCGuideExampleResourceGroup"
  location = var.location
}

resource "random_pet" "table_name" {}

resource "azurerm_cosmosdb_account" "tfc_example_account" {
  name                 = "tfc-guideexample-account"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
  offer_type           = "Standard"

  capabilities {
    name = EnableTable
  }
  
  consistency_policy {
    consistency_level = "BoundedStaleness"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_table" "tfc_example_table" {
  name                = "${var.db_table_name}-${random_pet.table_name.id}"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.tfc_example_account.name
}
