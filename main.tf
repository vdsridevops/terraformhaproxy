terraform {
  required_version = ">= 0.12.16"
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "webapp1" {
  source = "./modules/webapp1"
}

module "webapp2" {
  source = "./modules/webapp2"
}

module "haproxy" {
  source = "./modules/haproxy"
}
