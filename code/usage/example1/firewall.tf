module "gcp_firewall" {
  source = "../../module/firewall"
  gcp_firewall_name = var.gcp_firewall_name
  gcp_vpn_name = module.gcp_vpn.gcp_vpc_name
  gcp_firewall_protocol_ports = [{
    protocol = "icmp"
    ports = []
  },{
    protocol = "tcp"
    ports = ["80", "8080", "443", "22"]
  }
  ]
}

# resource "google_compute_firewall" "firewall" {
#   name    = "network01-firewall"
#   network = google_compute_network.vpc_network01.name

#   allow {
#     protocol = "icmp"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "8080", "443", "22"]
#   }

#   source_ranges = ["0.0.0.0/0"]
# }
