resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network
  auto_create_subnetworks = var.subnet_auto_create
}

resource "google_compute_subnetwork" "network-with-private-ip-ranges" {
  name          = var.gcp_subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.id
}

