resource "google_compute_firewall" "rule" {
  name      = var.name
  network   = var.network
  direction = upper(var.type)

  allow {
    protocol = var.protocol
    ports    = var.protocol == "all" ? null : var.ports
  }

  target_tags         = var.target_tags
  source_ranges       = var.type == "ingress" ? var.source_ranges : null
  source_tags         = var.type == "ingress" ? var.source_tags : null
  destination_ranges  = var.type == "egress" ? var.destination_ranges : null
}
