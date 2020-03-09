provider "random" {}

resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.cluster-name}-${terraform.workspace}-"
}

resource "google_container_cluster" "cluster" {
  name = random_id.id.hex
  location = var.region
  initial_node_count = 1
  project = var.project-id
}

provider "kubernetes" {
  host     = google_container_cluster.cluster.endpoint
  username = google_container_cluster.cluster.master_auth.0.username
  password = google_container_cluster.cluster.master_auth.0.password
  client_certificate     = base64decode(google_container_cluster.cluster.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.cluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)
//  alias = "default"
}

resource "google_service_account_key" "mykey" {
  service_account_id = "projects/${var.project-id}/serviceAccounts/${var.credentials-email}"
}

resource "kubernetes_secret" "google-application-credentials" {
  metadata {
    name = "cloudsql-instance-credentials" # The name of the secret
  }
  data = {
    "credentials.json" = base64decode(google_service_account_key.mykey.private_key)
  }
}