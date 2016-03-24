provider "google" {
  credentials = "${file("secrets/mattcalthrop-3ed5cdde44c1.json")}"
  project = "mattcalthrop"
  region = "europe-west1"
}

# Create a new instance
resource "google_compute_instance" "default" {
  name = "test-google-compute-instance-via-terraform"
  machine_type = "n1-standard-1"
  zone = "europe-west1-d"
  tags = [
    "tag-1",
    "tag-2"
  ]

  disk {
    image = "ubuntu-1510-wily-v20160315"
  }

  // Local SSD disk
  disk {
    type = "local-ssd"
    scratch = true
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    meta-1-name = "meta-1-value"
  }

  metadata_startup_script = "echo $(date) > /test.txt"

  service_account {
    scopes = [
      "userinfo-email",
      "compute-ro",
      "storage-ro"
    ]
  }
}