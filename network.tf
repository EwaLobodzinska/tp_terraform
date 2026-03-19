resource "google_compute_network" "vpc" {
  name                    = "ewa-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "ewa-subnet"
  region        = var.region
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "ewa-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ewa-ssh"]
}

resource "google_compute_firewall" "allow_web" {
  name    = "ewa-web"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = [tostring(var.web_port)]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ewa-web"]
}

resource "google_compute_firewall" "allow_api" {
  name    = "ewa-api"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = [tostring(var.api_port)]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ewa-api"]
}

