variable "gcp_compute_name" {
  type = string
}

variable "gcp_compute_type" {
  type = string
  default = "e2-standard-2"
}

variable "gcp_zone" {
  type = string  
}

variable "gcp_tag" {
  type = list
  default = ["compute"]
}

variable "gcp_image_family" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "gcp_image_family_project" {
  type = string
  default = "ubuntu-os-cloud"
}

variable "ssh_key" {
 type = string
}

variable "gcp_user" {
 type = string  
}

variable "gcp_network" {
    type = string
}

variable "gcp_subnetwork" {
    type = string
}

variable "external_ip_address" {
  type = string
}