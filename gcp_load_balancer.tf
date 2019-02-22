resource "google_compute_global_address" "myapp-prd" {
  name    = "myapp-prd"
  project = "${var.project_id}"
}

resource "google_compute_url_map" "myapp-prd" {
  name            = "myapp-prd"
  default_service = "${google_compute_backend_service.myapp-prd.self_link}"
  project         = "${var.project_id}"
}

resource "google_compute_target_http_proxy" "myapp-prd" {
  name             = "myapp-prd"
  url_map          = "${google_compute_url_map.myapp-prd.self_link}"
}

resource "google_compute_global_forwarding_rule" "myapp-prd-http" {
  name        = "myapp-prd-http"
  target      = "${google_compute_target_http_proxy.myapp-prd.self_link}"
  ip_address  = "${google_compute_global_address.myapp-prd.address}"
  port_range  = "80"
  project     = "${var.project_id}"
}

resource "google_compute_target_https_proxy" "myapp-prd" {
  name             = "myapp-prd-https"
  url_map          = "${google_compute_url_map.myapp-prd.self_link}"
  ssl_certificates = "${var.ssl_certificates}"
}

resource "google_compute_global_forwarding_rule" "myapp-prd-https" {
  name        = "myapp-prd-https"
  target      = "${google_compute_target_https_proxy.myapp-prd.self_link}"
  ip_address  = "${google_compute_global_address.myapp-prd.address}"
  port_range  = "443"
  project     = "${var.project_id}"
}

output "load-balancer-ip" {
  value = "${google_compute_global_address.myapp-prd.address}"
}
