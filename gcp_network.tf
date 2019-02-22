resource "google_compute_network" "myapp" {
  name                    = "${var.network_name}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "myapp-prd" {
  name                     = "${var.network_name}"
  ip_cidr_range            = "${var.network_cidr}"
  network                  = "${google_compute_network.myapp.self_link}"
  description              = "Quick Buy production subnetwork"
  region                   = "${var.region}"
  private_ip_google_access = true
}
