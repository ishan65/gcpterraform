provider "google" {
    credentials = file(var.gcp_key)
    project = var.gcp_project
    region = var.gcp_region[0]
}