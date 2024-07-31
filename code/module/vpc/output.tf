output "gcp_vpc_name" {
  value = google_compute_network.vpc_network.name
}

output "gcp_subnet_name" {
  value = google_compute_subnetwork.network-with-private-ip-ranges.name
}
