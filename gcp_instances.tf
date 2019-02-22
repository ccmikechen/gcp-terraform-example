resource "google_compute_instance" "myapp-prd-1" {
  name         = "myapp-prd-1"
  machine_type = "${var.machine_type}"
  zone         = "${var.region_zone}"
  description  = "myapp Manager Production server"
  tags         = ["server", "production", "myapp"]

  boot_disk {
    initialize_params {
      image = "${var.image_project}/${var.image_family}"
    }
  }

  scratch_disk {
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.myapp-prd.name}"
  }

  service_account {
    scopes = ["compute-ro", "storage-ro", "monitoring", "sql-admin"]
  }

  scheduling {
    on_host_maintenance = "MIGRATE"
    automatic_restart  = true
  }

  metadata {
    sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }

  metadata_startup_script = <<EOT
mkdir -p /usr/lib/systemd/system/cloud_sql_proxy.service.d
echo "${data.template_file.cloud-sql-proxy-settings.rendered}" > /usr/lib/systemd/system/cloud_sql_proxy.service.d/settings.conf
EOT
}

data "template_file" "cloud-sql-proxy-settings" {
  template = "${file("${path.module}/templates/cloud_sql_proxy_settings.conf.tpl")}"

  vars {
    project_id    = "${var.project_id}"
    zone          = "${var.region_zone}"
    instance_name = "${var.database_instance}"
  }
}
