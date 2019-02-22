resource "google_compute_backend_service" "myapp-prd" {
  name        = "myapp-prd"
  description = "myapp production server"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  enable_cdn  = false

  backend {
    group = "${google_compute_instance_group.myapp-prd-group.self_link}"
  }

  health_checks = ["${google_compute_http_health_check.myapp.self_link}"]
}

resource "google_compute_http_health_check" "myapp" {
  name               = "myapp"
  request_path       = "/health_check"
  check_interval_sec = 300
  timeout_sec        = 60
}
