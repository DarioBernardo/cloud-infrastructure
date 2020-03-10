output "pubsub_subscription_name" {
  value = google_pubsub_subscription.pubsub_default_subsciption.name
}

output "topic_name" {
  value = google_pubsub_topic.pubsub-topic.name
}