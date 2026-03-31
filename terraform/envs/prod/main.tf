module "prod" {
  source = "../../modules/environment"

  env_name     = "prod"
  location     = var.location
  server_type  = var.server_type
  ssh_key_name = var.ssh_key_name
}
