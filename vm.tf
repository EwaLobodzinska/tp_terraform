resource "google_compute_address" "public_ip" {
  name   = "ewa-web-ip"
  region = var.region
}

resource "google_compute_instance" "vm" {
  name         = "ewa-web-vm"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["ewa-ssh", "ewa-web"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(pathexpand("~/.ssh/id_ed25519.pub"))}"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    access_config {
      nat_ip = google_compute_address.public_ip.address
    }
  }
}