# Original: see https://cloud.google.com/compute/docs/load-balancing/network/example

provider "google" {
  region = "${var.region}"
  project = "${var.project_name}"
  credentials = "${file("${var.credentials_file}")}"
}

resource "google_compute_http_health_check" "default" {
  name = "tf-www-basic-check"
  request_path = "/"
  check_interval_sec = 1
  healthy_threshold = 1
  unhealthy_threshold = 10
  timeout_sec = 1
}

resource "google_compute_target_pool" "default" {
  name = "tf-www-target-pool"
  instances = ["${google_compute_instance.www.*.self_link}"]
  health_checks = ["${google_compute_http_health_check.default.name}"]
}

resource "google_compute_forwarding_rule" "default" {
  name = "tf-www-forwarding-rule"
  target = "${google_compute_target_pool.default.self_link}"
  port_range = "80"
}

resource "google_compute_instance" "www" {
  count = 3

  name = "tf-www-${count.index}"
  machine_type = "f1-micro"
  zone = "${var.region_zone}"
  tags = ["www-node"]

  disk {
    image = "ubuntu-os-cloud/ubuntu-1404-trusty-v20160314"
  }

  network_interface {
    network = "default"
    access_config {
        # Ephemeral
    }
  }

  metadata {
    ssh-keys = "root:${file("${var.public_key_file}")}"
  }

  provisioner "file" {
    source = "${var.install_script_src}"
    destination = "${var.install_script_dest}"
    connection {
      type = "ssh"
      user = "root"
      private_key = "${file("${var.private_key_file}")}"
      agent = false
    }
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      private_key = "${file("${var.private_key_file}")}"
      agent = false
    }
    inline = [
      "chmod +x ${var.install_script_dest}",
      "${var.install_script_dest} ${count.index}"
    ]
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

resource "google_compute_firewall" "default" {
  name = "tf-www-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["www-node"]
}
