resource "azurerm_virtual_network_gateway" "vpn" {
  name                = "vpn-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw1"
  ip_configuration {
    public_ip_address_id = azurerm_public_ip.vpn.id
    subnet_id            = var.vnet_gateway_subnet_id
    name                 = "vpn-gateway-ipconfig"
  }
}

resource "azurerm_public_ip" "vpn" {
  name                = "vpn-gateway-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}
