resource "google_compute_firewall" "firewall" {
  name    = var.gcp_firewall_name
  network = var.gcp_vpn_name

dynamic  "allow" {
    for_each = var.gcp_firewall_protocol_ports
    content {
        protocol = allow.value.protocol
        ports    = allow.value.ports      
    }
  }
  source_ranges = var.gcp_ip_source_range
}
