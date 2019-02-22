variable "project_id" {
  default = "myapp-prod"
}

variable "region" {
  default = "asia-northeast1"
}

variable "region_zone" {
  default = "asia-northeast1-c"
}

variable "network_name" {
  default = "myapp"
}

variable "network_cidr" {
  default = "10.127.0.0/20"
}

variable "image_family" {
  default = "centos-7"
}

variable "image_project" {
  default = "centos-cloud"
}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "bastion_image_family" {
  default = "centos-7"
}

variable "bastion_image_project" {
  default = "centos-cloud"
}

variable "bastion_machine_type" {
  default = "f1-micro"
}

variable "ssl_certificates" {
  default = [
    "https://www.googleapis.com/compute/beta/projects/myapp-prod/global/sslCertificates/myapp",
    "https://www.googleapis.com/compute/beta/projects/myapp-prod/global/sslCertificates/myapp-app"
  ]
}

variable "database_instance" {
  default = "myapp-prd"
}

variable "database_name" {
  default = "myapp-prd"
}

variable "database_version" {
  default = "POSTGRES_9_6"
}

variable "database_username" {
  default = "postgres"
}

variable "ssh_user" {
}

variable "ssh_pub_key_file" {
  default = "~/.ssh/id_rsa.pub"
}

variable "redis_tier" {
  default = "BASIC"
}

variable "redis_size" {
  default = "1"
}

variable "redis_version" {
  default = "REDIS_3_2"
}
