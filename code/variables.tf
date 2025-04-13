variable "gcp_region" {
  type = list(string)
  default = ["us-central1", "europe-west1", "us-west1"]
}

variable "gcp_project" {
  type = string
  default = "psychic-heading-456716-b1"
}

variable "gcp_key" {
  type = string
  default = "../psychic-heading-456716-b1-fb1ad3d7bc57.json"
}

variable "ssh_key" {
 type = string
 default = "/root/.ssh/id_gcptera.pub"
}

variable "priv_ssh_key" {
 type = string
 default = "/root/.ssh/id_gcptera"
}