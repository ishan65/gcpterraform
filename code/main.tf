module "compute01" {
  source = "./module"
  count = 1
}

module  "vpc_network01" {
  source = "./module"
}


module "compute_external_ip" {
  source = "./module"
  count = 1
}


module "firewall01" {
  source = "./module"
}

module "compute_ip_output" {
  source = "./module"
}
