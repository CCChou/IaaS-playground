locals {
  use_cloud_init = length(var.cloud_init_parts) > 0
  use_gpu        = var.gpu_type != null
}

data "cloudinit_config" "setup" {
  count         = local.use_cloud_init ? 1 : 0
  gzip          = true
  base64_encode = true

  dynamic "part" {
    for_each = var.cloud_init_parts
    content {
      filename     = part.value.filename
      content_type = "text/x-shellscript"
      content      = part.value.content
    }
  }
}

data "google_compute_network" "default" {
  name = "default"
}

resource "google_compute_instance" "gce_instance" {
  count        = var.counts
  name         = "${var.name}-${count.index}"
  machine_type = var.machine_type
  tags         = [var.name]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.volume
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    access_config {}
  }

  metadata = {
    "ssh-keys"  = "${var.ssh_user}:${var.ssh_public_key}"
    "user-data" = local.use_cloud_init ? data.cloudinit_config.setup[0].rendered : null
  }

  scheduling {
    preemptible         = var.preemptible
    automatic_restart   = var.preemptible || local.use_gpu ? false : true
    provisioning_model  = var.preemptible ? "SPOT" : "STANDARD"
    on_host_maintenance = local.use_gpu ? "TERMINATE" : "MIGRATE"
  }

  dynamic "guest_accelerator" {
    for_each = local.use_gpu ? [1] : []
    content {
      type  = var.gpu_type
      count = var.gpu_count
    }
  }
}

module "allow_outbound_all" {
  source = "../gcp-firewall-rule"

  name                = "${var.name}-allow-outbound-all"
  network             = data.google_compute_network.default.self_link
  type                = "egress"
  protocol            = "all"
  target_tags         = [var.name]
  destination_ranges  = ["0.0.0.0/0"]
}

module "allow_inbound_ssh" {
  source = "../gcp-firewall-rule"

  name          = "${var.name}-allow-inbound-ssh"
  network       = data.google_compute_network.default.self_link
  type          = "ingress"
  protocol      = "tcp"
  ports         = ["22"]
  target_tags   = [var.name]
  source_ranges = ["0.0.0.0/0"]
}

module "allow_self_ingress" {
  count  = var.allow_self_ingress ? 1 : 0
  source = "../gcp-firewall-rule"

  name        = "${var.name}-allow-self-ingress"
  network     = data.google_compute_network.default.self_link
  type        = "ingress"
  protocol    = "all"
  target_tags = [var.name]
  source_tags = [var.name]
}
