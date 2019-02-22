module "postgresql-db" {
  source           = "GoogleCloudPlatform/sql-db/google"
  name             = "${var.database_instance}"
  db_name          = "${var.database_name}"
  user_name        = "${var.database_username}"
  user_host        = ""
  database_version = "${var.database_version}"
  region           = "${var.region}"
}

output "psql_user_password" {
  value = "${module.postgresql-db.generated_user_password}"
}
