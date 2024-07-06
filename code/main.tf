resource "google_compute_address" "compute_external_ip" {
  name = "myip"
}


data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2004-lts-arm64"
  project = "ubuntu-os-cloud"
}

resource "google_compute_network" "vpc_network01" {
  name = "vpc-network01"
  auto_create_subnetworks = false
}


resource "google_service_account" "service_account01" {
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}


resource "google_compute_subnetwork" "network-with-private-ip-ranges" {
  name          = "us-central1-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
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
  name         = "compute01"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"
  tags = ["compute"]
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.self_link
      labels = {
        my_label = "value"
      }
    }
  }
  network_interface {
    network = google_compute_network.vpc_network01.self_link
    subnetwork = google_compute_subnetwork.network-with-private-ip-ranges.self_link
    access_config {
      nat_ip = google_compute_address.compute_external_ip.address
    }
  }
  service_account {
    email  = google_service_account.service_account01.email
    scopes = ["cloud-platform", "service-control"]
  }
}


output "external_ip" {
  value = google_compute_address.compute_external_ip.address
}