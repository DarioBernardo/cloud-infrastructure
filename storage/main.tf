resource "google_storage_bucket" "bucket-storage" {
  name = "${var.bucket-name}-${terraform.workspace}"
  location = var.region
  project = var.project-id
}