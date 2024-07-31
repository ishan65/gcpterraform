variable "gcp_firewall_name" {
  type = string
}

variable "gcp_vpn_name" {
    type = string
}

variable "gcp_firewall_protocol_ports" {
  type = list(object({
    protocol = string
    ports = list(string)
  }))
}

variable "gcp_ip_source_range" {
  type = list(string)
  default = ["0.0.0.0/0"]
}