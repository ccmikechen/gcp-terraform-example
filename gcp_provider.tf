provider "google" {
  credentials = "${file("./credential.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket  = "myapp"
    path    = "terraform/terraform.tfstate"
    project = "myapp-prod"
  }
}
