module "gcp_vpn" {
  source = "../../module/vpc"
  gcp_region = var.gcp_region
  vpc_network = var.vpc_network
  subnet_auto_create = var.subnet_auto_create
  gcp_subnet_name = "${var.gcp_region}-${var.gcp_subnet_name}"
  ip_cidr_range = var.ip_cidr_range
}

