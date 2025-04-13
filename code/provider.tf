provider "google" {
    credentials = file(var.gcp_key)
    project = var.gcp_project
    region = local.selected_region
}