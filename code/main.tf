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
  name = "myip"
}


resource "google_compute_subnetwork" "network-with-private-ip-ranges" {
  name          = "${var.gcp_region[0]}-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
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
  count = 1

  name         = "compute0${count.index}-${var.gcp_region[0]}"
  machine_type = "e2-standard-2"
  zone         = "${data.google_compute_zones.zone_info.names[0]}"
  tags         = ["compute"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.self_link
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network01.self_link
    subnetwork = "${google_compute_subnetwork.network-with-private-ip-ranges.self_link}"

    access_config {
      nat_ip = "${google_compute_address.compute_external_ip.address}"
    }
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      private_key = file(var.priv_ssh_key)
      user = "gcptera"
      host = "${google_compute_address.compute_external_ip.address}"
    }
    inline = [
      "sudo apt-get update",
      "sudo apt install -y apache2",
      "sudo echo IXT65 `date` > 1.txt",
      "sudo systemctl restart apache2",
    ]
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
