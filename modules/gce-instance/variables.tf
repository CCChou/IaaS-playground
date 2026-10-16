variable "name" {
  type    = string
  default = "gce_instance"
}

variable "image" {
  description = "Image in {project}/{family-or-image} form, e.g. ubuntu-os-cloud/ubuntu-2404-lts-amd64"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
}

variable "machine_type" {
  type    = string
  default = "n1-standard-4"
}

variable "ssh_user" {
  description = "Login user the ssh_public_key metadata is registered under"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClrBErj5SjX9/tWl4OZfnwvVVaSHRKw5RSEDtNnEs03Cd6vXTiQxVc1hln2SyRxyiVuWw2no7h/5srzOC25kIrGVtgeCQWOZuVvwhq9FMrdnJoK4MfpQJ9ivyylW0PzMUqs2C9f7uot9Txan7p+Avs5ubyTAjIxEElyoOqcgVMms3fsAN+ELcV5Rvrd93rYce3EoQR7FdZnC4d7uF1aFeq9jV6AONM0r8vdChY1KYxeVULrxAOkioTNHh1qkPK4x0OtqSxLw1h81mRTCr7E0tivC78Ud3Eyikkd6hGjRva+Ydt8cd5Lsg9VIPX4oBEW2vYCB0MMuJ+RPWirwsJ87mdZt5K+1D7Fz4wvd++5KzOdGqkMceRgL6dML+m30Bo63I6gy3FFHcPb2/oICxj7E9PGX6NXEVZFDmVq+WHhZpoDOLmFgTYFAy+PAxKFfGnk3IdcaVSxgNwprCqEZc+yymNe6XUCRQO0oIXXqw5jJn899DLgDlCXtqjyipm4ijVHS8= dennischou@dechou-mac"
}

variable "counts" {
  type    = number
  default = 1
}

variable "volume" {
  type    = number
  default = 100
}

variable "cloud_init_parts" {
  type = list(object({
    filename = string
    content  = string
  }))
  default = []
}

variable "allow_self_ingress" {
  type    = bool
  default = false
}

variable "preemptible" {
  description = "Run as a Spot VM (cheap, can be reclaimed at any time)"
  type        = bool
  default     = false
}

variable "gpu_type" {
  description = "Accelerator type to attach, e.g. nvidia-tesla-t4. Leave null for no GPU"
  type        = string
  default     = null
}

variable "gpu_count" {
  type    = number
  default = 1
}
