variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "public_ip_id" {}              # para App Gateway
variable "ssl_cert_name" {}             # se usando SSL no App Gateway
variable "db_password" { sensitive = true }
variable "aks_id" {}                    # para associar logs ao AKS
