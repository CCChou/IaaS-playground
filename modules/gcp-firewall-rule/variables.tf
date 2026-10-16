# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  type        = string
  description = "The name of the firewall rule"
}

variable "network" {
  type        = string
  description = "Self link of the VPC network to attach the rule to"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "type" {
  type        = string
  description = "The direction of traffic the rule applies to: ingress or egress"
  default     = "ingress"
}

variable "protocol" {
  type        = string
  description = "The IP protocol to allow (tcp, udp, icmp, all...)"
  default     = "tcp"
}

variable "ports" {
  type        = list(string)
  description = "Ports to allow; must be omitted when protocol is \"all\""
  default     = null
}

variable "target_tags" {
  type        = list(string)
  description = "Network tags of the instances this rule applies to"
  default     = null
}

variable "source_ranges" {
  type        = list(string)
  description = "CIDR ranges allowed as source (ingress only)"
  default     = null
}

variable "source_tags" {
  type        = list(string)
  description = "Network tags allowed as source, for self-referencing rules (ingress only)"
  default     = null
}

variable "destination_ranges" {
  type        = list(string)
  description = "CIDR ranges allowed as destination (egress only)"
  default     = null
}
