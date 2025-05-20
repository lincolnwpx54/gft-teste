resource "azurerm_api_management" "apim" {
  name                = "apim-xpto"
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = "XPTO"
  publisher_email     = "infra@xpto.com.br"
  sku_name            = "Developer_1"

  virtual_network_type = "Internal"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "prod"
  }
}
