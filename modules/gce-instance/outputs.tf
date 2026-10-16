output "network_tag" {
  description = "Network tag applied to the instances, used by firewall rules to target them"
  value       = var.name
}

output "public_ip" {
  description = "Ephemeral public IPs of the instances"
  value       = google_compute_instance.gce_instance[*].network_interface[0].access_config[0].nat_ip
}
