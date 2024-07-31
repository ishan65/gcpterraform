variable "gcp_region" {
  type = string
}

variable "gcp_project" {
  type = string
}

variable "gcp_key" {
  type = string
}

variable "ssh_key" {
 type = string
}

variable "priv_ssh_key" {
 type = string
}

variable "vpc_network" {
  type = string
}

variable "gcp_image_family" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "gcp_image_family_project" {
  type = string
  default = "ubuntu-os-cloud"
}

variable "subnet_auto_create" {
  type = bool
  default = true
}

variable "ip_cidr_range" {
  type = string
}

variable "gcp_subnet_name" {
  type = string
}

variable "external_ip_name" {
  type = string
}

variable "gcp_user" {
  type = string
}


variable "gcp_tag" {
  type = list(string)
}

variable "gcp_compute_name" {
  type = string   
}

variable "compute_num" {
  type = number
}

variable "gcp_firewall_name" {
  type = string
}

variable "gcp_ip_source_range" {
  type = list(string)
  default = ["0.0.0.0/0"]
}
