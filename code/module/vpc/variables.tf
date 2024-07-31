variable "vpc_network" {
 type = string 
}

variable "subnet_auto_create" {
  type = bool
  default = true
}

variable "ip_cidr_range" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "gcp_subnet_name" {
  type = string
}
