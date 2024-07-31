data "google_compute_zones" "zone_info" {
}

module "gcp_computes" {
  count = var.compute_num
  source = "../../module/compute"
  gcp_zone = "${data.google_compute_zones.zone_info.names[0]}"
  gcp_compute_name = "${var.gcp_compute_name}-${count.index}-${var.gcp_region}"
  gcp_network = module.gcp_vpn.gcp_vpc_name
  gcp_user = var.gcp_user
  ssh_key = var.ssh_key
  external_ip_address = module.gcp_static_ip[count.index].external_ip
  gcp_tag = var.gcp_tag
  gcp_subnetwork = module.gcp_vpn.gcp_subnet_name
  depends_on = [ 
    module.gcp_vpn,
    module.gcp_static_ip,
   ]
}

module "gcp_static_ip" {
  count = var.compute_num
  source = "../../module/external"
  external_ip_name = "${var.external_ip_name}-${count.index}"
}


# resource "google_compute_instance" "compute" {
#   count = 1

#   name         = "compute0${count.index}-${var.gcp_region[0]}"
#   machine_type = "e2-standard-2"
#   zone         = 
#   tags         = ["compute"]

#   boot_disk {
#     initialize_params {
#       image = data.google_compute_image.ubuntu_image.self_link
#     }
#   }

#   network_interface {
#     network    = google_compute_network.vpc_network01.self_link
#     subnetwork = "${google_compute_subnetwork.network-with-private-ip-ranges.self_link}"

#     access_config {
#       nat_ip = "${google_compute_address.external_ip[count.index].address}"
#     }
#   }

#   service_account {
#     scopes = ["https://www.googleapis.com/auth/cloud-platform"]
#   }
# }


# resource "google_compute_project_metadata" "gcp_ssh_key" {
#   metadata = {
#     ssh-keys = "gcptera:${file(var.ssh_key)}"
#   }
# }
