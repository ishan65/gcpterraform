output "external_ip" {
  value = google_compute_address.static_external_ip.address
}

