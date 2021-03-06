provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source           = "../modules/db"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
  deploy_mongodb   = "false"
}

module "app" {
  source              = "../modules/app"
  public_key_path     = "${var.public_key_path}"
  private_key_path    = "${var.private_key_path}"
  zone                = "${var.zone}"
  app_disk_image      = "${var.app_disk_image}"
  deploy_puma         = "false"
  mongodb_external_ip = "${module.db.db_external_ip}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["83.217.212.168/32"]
}
