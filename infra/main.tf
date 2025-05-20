module "vpc" {
  source     = "./modules/network"
  region     = var.region
  cidr_block = "10.0.0.0/16"
}

module "eks" {
  source      = "./modules/kubernetes"
  cluster_name = "xpto-cluster"
  node_count   = 3
  ...
}
