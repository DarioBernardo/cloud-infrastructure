// VPC network
resource "google_compute_network" "private_network" {
  provider = google-beta
  name = "test-private-network-2"
  auto_create_subnetworks = "false"
//  project = var.project-id
}

resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "test-private-ip-address-2"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = google_compute_network.private_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_subnetwork" "subnet" {
  name          = "test-subnet"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.private_network.self_link
  region        = var.region
}

# VPC firewall configuration
# Create a firewall rule that allows internal communication across all protocols:
resource "google_compute_firewall" "firewall-int" {
  name    = "default-firewall-int"
  network = google_compute_network.private_network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [google_compute_subnetwork.subnet.ip_cidr_range]
}



# Create a firewall rule that allows external SSH, ICMP, and HTTPS:
resource "google_compute_firewall" "firewall-ext" {
  name    = "default-firewall-ext"
  network = google_compute_network.private_network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443"]
  }

  source_ranges = ["0.0.0.0/0"]
}
