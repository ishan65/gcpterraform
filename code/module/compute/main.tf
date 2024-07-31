data "google_compute_image" "compute_image" {
  family  = var.gcp_image_family
  project = var.gcp_image_family_project
}

resource "google_compute_instance" "compute" {
  name         = var.gcp_compute_name
  machine_type = var.gcp_compute_type
  zone         = var.gcp_zone
  tags         = var.gcp_tag

  boot_disk {
    initialize_params {
      image = data.google_compute_image.compute_image.self_link
    }
  }

  network_interface {
    network    = var.gcp_network
    subnetwork = var.gcp_subnetwork

    access_config {
      nat_ip = var.external_ip_address
    }
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_project_metadata" "gcp_ssh_key" {
  metadata = {
    ssh-keys = "${var.gcp_user}:${file(var.ssh_key)}"
  }
}
