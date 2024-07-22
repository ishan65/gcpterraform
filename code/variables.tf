variable "gcp_region" {
  type = list(string)
  default = ["us-central1", "europe-west1", "us-west1"]
}

variable "gcp_project" {
  type = string
  default = "learn-426012"
}

variable "gcp_key" {
  type = string
  default = "../learn-426012-199996f158be.json"
}

variable "ssh_key" {
 type = string
 default = "/root/.ssh/id_gcptera.pub"
}