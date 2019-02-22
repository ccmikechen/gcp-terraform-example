resource "google_compute_instance_group" "myapp-prd-group" {
  name        = "myapp-prd-group"
  description = "myapp production server group"
  zone        = "${var.region_zone}"
  instances = [
    "${google_compute_instance.myapp-prd-1.self_link}"
  ]
}
