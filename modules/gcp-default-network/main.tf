resource "google_compute_network" "default" {
  name                    = "default"
  auto_create_subnetworks = true
}
