// PUB/SUB Topic
resource "google_pubsub_topic" "pubsub-topic" {
  name = var.topic-name
  project = var.project-id
}

// This is the pubsub topic default subscriber
resource "google_pubsub_subscription" "pubsub_default_subsciption" {
  name  = var.default-subscription-name
  project = var.project-id
  topic = google_pubsub_topic.pubsub-topic.name
  ack_deadline_seconds = 20
}