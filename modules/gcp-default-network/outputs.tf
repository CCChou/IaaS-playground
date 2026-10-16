output "self_link" {
  description = "Self link of the project's default network"
  value       = data.google_compute_network.default.self_link
}
