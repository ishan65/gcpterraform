resource "google_compute_address" "compute_external_ip" {
  name = "myip"
}


data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2004-lts-arm64"
  project = "ubuntu-os-cloud"
}


resource "google_compute_instance" "compute01" {
  name         = "compute01"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"
  tags = ["compute"]
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.self_link
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.compute_external_ip.address
    }
  }
  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}


output "external_ip" {
  value = google_compute_address.compute_external_ip.address
}