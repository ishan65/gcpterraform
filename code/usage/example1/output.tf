output "external_ip" {
  value = module.gcp_static_ip[*].external_ip
}
