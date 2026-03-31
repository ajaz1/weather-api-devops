module "dev" {
  source = "../../modules/environment"

  env_name      = "dev"
  location      = var.location
  server_type   = var.server_type
  ssh_key_name  = var.ssh_key_name
}
