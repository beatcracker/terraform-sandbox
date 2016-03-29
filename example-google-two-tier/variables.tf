variable "region" {
  default = "europe-west1"
}

variable "region_zone" {
  default = "europe-west1-c"
}

variable "project_name" {
  default = "mattcalthrop"
}

variable "credentials_file_path" {
  default = "../secrets/mattcalthrop-3ed5cdde44c1.json"
}

variable "public_key_file" {
  default = "~/.ssh/gcloud_id_rsa.pub"
}

variable "private_key_file" {
  default = "~/.ssh/gcloud_id_rsa"
}

variable "install_script_src" {
  default = "scripts/install.sh"
}

variable "install_script_dest" {
  default = "/tmp/install.sh"
}
