output "name" {
  description = "Cluster name"
  value       = google_container_cluster.primary.name
}


output "version" {
    value = google_container_cluster.primary.min_master_version
}

