resource "google_compute_firewall" "myapp-bastion" {
  name    = "myapp-bastion"
  network = "${google_compute_network.myapp.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["myapp-bastion"]
}

resource "google_compute_firewall" "myapp-prd-ssh" {
  name    = "myapp-prd-ssh"
  network = "${google_compute_subnetwork.myapp-prd.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["myapp-bastion"]
  target_tags = ["production"]
}

resource "google_compute_firewall" "myapp-prd" {
  name    = "myapp-prd"
  network = "${google_compute_subnetwork.myapp-prd.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["production"]
}
