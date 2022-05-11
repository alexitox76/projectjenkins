# Generate a random storage name
resource "random_string" "tf-name" {
  length  = 8
  upper   = false
  number  = true
  lower   = true
  special = false
}

# Create a resource group for the Terraform State File

data "azurerm_resources" "resource-group" {
  resource_group_name = "RGOrange-Test"
}

# Create a Storage Accont for the Terraform State File

resource "azurerm_storage_account" "state-sta" {
  depends_on = [data.azurerm_resources.resource-group]

  name                      = "${lower(var.user)}tf${random_string.tf-name.result}}"
  resource_group_name       = data.azurerm_resources.resource-group
  location                  = data.azurerm_resources.resource-group.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  access_tier               = "Hot"
  account_replication_type  = "ZRS"
  enable_https_traffic_only = true

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Utilizzatore = var.user
  }

}

# Create a Storage Container for the Core State File

resource "azurerm_storage_container" "terraform-container" {
  depends_on = [azurerm_storage_account.state-sta]

  name                 = "terraform-tfstate"
  storage_account_name = azurerm_storage_account.state-sta.name
}