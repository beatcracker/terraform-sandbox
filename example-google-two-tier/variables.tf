variable "region" {
  default = "europe-west1"
}

variable "region_zone" {
  default = "europe-west1-c"
}

variable "project_name" {
  default = "mattcalthrop"
}

variable "credentials_file" {
  description = "Location of Google Compute credentials file"
  default = "../secrets/mattcalthrop-3ed5cdde44c1.json"
}

variable "public_key_file" {
  description = "Location of file containing public key"
  default = "~/.ssh/gcloud_id_rsa.pub"
}

variable "private_key_file" {
  description = "Location of file containing private key"
  default = "~/.ssh/gcloud_id_rsa"
}

variable "install_script_src" {
  description = "Location of install script within this repository"
  default = "scripts/install.sh"
}

variable "install_script_dest" {
  description = "Location to put the install script on each destination resource"
  default = "/tmp/install.sh"
}
