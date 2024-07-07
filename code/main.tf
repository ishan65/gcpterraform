data "google_compute_image" "ubuntu_image" {
   family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

 data "google_compute_zones" "zone_info" {
}


resource "google_compute_network" "vpc_network01" {
  name                    = "vpc-network01"
  auto_create_subnetworks = false
}

resource "google_compute_address" "compute_external_ip" {
  count = length(data.google_compute_zones.zone_info.names)
  name = "myip-${data.google_compute_zones.zone_info.names[count.index]}"
}


resource "google_compute_subnetwork" "network-with-private-ip-ranges" {
  count = length(data.google_compute_zones.zone_info.names)

  name          = "${data.google_compute_zones.zone_info.names[count.index]}-subnetwork"
  ip_cidr_range = "10.0.${count.index}.0/24"
  region        = var.gcp_region[0]
  network       = google_compute_network.vpc_network01.id
}

resource "google_compute_firewall" "firewall01" {
  name    = "network01-firewall"
  network = google_compute_network.vpc_network01.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "compute01" {
  count = length(data.google_compute_zones.zone_info.names)

  name         = "compute0${count.index}-${data.google_compute_zones.zone_info.names[count.index]}"
  machine_type = "e2-standard-2"
  zone         = "${data.google_compute_zones.zone_info.names[count.index]}"
  tags         = ["compute"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.self_link
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network01.self_link
    subnetwork = "${google_compute_subnetwork.network-with-private-ip-ranges[count.index].self_link}"

    access_config {
      nat_ip = "${google_compute_address.compute_external_ip[count.index].address}"
    }
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}


resource "google_compute_project_metadata" "gcp_ssh_key" {
  metadata = {
    ssh-keys = "gcptera:${file(var.ssh_key)}"
  }
}


output "external_ip" {
  value = google_compute_address.compute_external_ip[*].address
}


output "zoneinfo" {
  value = data.google_compute_zones.zone_info.names
}

