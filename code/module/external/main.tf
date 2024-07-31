resource "google_compute_address" "static_external_ip" {
  name = var.external_ip_name
}
