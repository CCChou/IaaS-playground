variable "name" {
  type    = string
  default = "ec2_instance"
}

# Ubuntu 24.04 in ap-southeast-2
variable "ami" {
  type    = string
  default = "ami-0ba8d27d35e9915fb"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
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

variable "user_data" {
  type    = string
  default = null
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
