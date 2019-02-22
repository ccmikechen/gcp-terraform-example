resource "google_compute_instance" "myapp-bastion" {
  name         = "myapp-bastion"
  machine_type = "${var.bastion_machine_type}"
  zone         = "${var.region_zone}"
  description  = "myapp bastion"
  tags         = ["server", "myapp-bastion"]

  boot_disk {
    initialize_params {
      image = "${var.bastion_image_project}/${var.bastion_image_family}"
    }
  }

  network_interface {
    access_config {
    }

    subnetwork = "${google_compute_subnetwork.myapp-prd.name}"
  }

  service_account {
    scopes = ["compute-ro", "storage-ro", "monitoring"]
  }

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart  = true
  }

  metadata {
    sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }
}

output "myapp-bastion-instance" {
  value = "${google_compute_instance.myapp-bastion.self_link}"
}

output "myapp-bastion" {
  value = "gcloud compute ssh --ssh-flag=\"-A\" $(terraform output myapp-bastion-instance)"
}
