resource "google_redis_instance" "cache" {
  name               = "myapp-redis"
  tier               = "${var.redis_tier}"
  memory_size_gb     = "${var.redis_size}"
  location_id        = "${var.region_zone}"
  authorized_network = "${google_compute_network.myapp.self_link}"
  redis_version      = "${var.redis_version}"
}
