resource "google_storage_bucket" "bucket-storage" {
  name = var.bucket-name
  location = var.region
  project = var.project-id
}