resource "azurerm_application_gateway" "appgw" {
  name                = "appgw-xpto"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "port-https"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name = "backend-pool"
  }

  http_settings {
    name                            = "https-settings"
    cookie_based_affinity           = "Disabled"
    port                            = 443
    protocol                        = "Https"
    pick_host_name_from_backend_address = false
    request_timeout                 = 30
  }

  listener {
    name                           = "https-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "port-https"
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_cert_name
  }

  tags = {
    environment = "prod"
  }
}
