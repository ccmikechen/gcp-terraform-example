resource "google_storage_bucket" "myapp" {
  name          = "myapp"
  location      = "${var.region}"
  storage_class = "STANDARD"
}

resource "google_storage_bucket_acl" "myapp-acl" {
  bucket         = "${google_storage_bucket.myapp.name}"
  predefined_acl = "private"
}
