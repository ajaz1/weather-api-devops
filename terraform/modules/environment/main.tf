terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

############################
# SSH KEY
############################

data "hcloud_ssh_key" "default" {
  name = var.ssh_key_name
}

############################
# PRIVATE NETWORK
############################

resource "hcloud_network" "private" {
  name     = "${var.env_name}-network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "subnet" {
  network_id   = hcloud_network.private.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

############################
# FIREWALL
############################

resource "hcloud_firewall" "api_fw" {
  name = "${var.env_name}-firewall"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = ["0.0.0.0/0"]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "8080"
    source_ips = ["0.0.0.0/0"]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = ["0.0.0.0/0"]
  }
}

############################
# API SERVERS
############################

resource "hcloud_server" "api" {
  count = 2

  name        = "${var.env_name}-api-${count.index}"
  image       = "ubuntu-22.04"
  server_type = var.server_type
  location    = var.location

  ssh_keys = [
    data.hcloud_ssh_key.default.name
  ]

  firewall_ids = [
    hcloud_firewall.api_fw.id
  ]

  network {
    network_id = hcloud_network.private.id
  }
}

############################
# DATABASE SERVER
############################

resource "hcloud_server" "db" {

  name        = "${var.env_name}-db"
  image       = "ubuntu-22.04"
  server_type = var.server_type
  location    = var.location

  ssh_keys = [
    data.hcloud_ssh_key.default.name
  ]

  firewall_ids = [
    hcloud_firewall.api_fw.id
  ]

  network {
    network_id = hcloud_network.private.id
  }
}

############################
# LOAD BALANCER
############################

resource "hcloud_load_balancer" "lb" {
  name               = "${var.env_name}-lb"
  load_balancer_type = "lb11"
  location           = var.location

}

resource "hcloud_load_balancer_target" "api" {
  count            = 2
  type             = "server"
  load_balancer_id = hcloud_load_balancer.lb.id
  server_id        = hcloud_server.api[count.index].id

  use_private_ip = false
}

resource "hcloud_load_balancer_service" "http" {
  load_balancer_id = hcloud_load_balancer.lb.id
  protocol         = "http"
  listen_port      = 80
  destination_port = 8080

  health_check {
    protocol = "http"
    port     = 8080
    interval = 10
    timeout  = 5
    retries  = 3

    http {
      path = "/health"
      status_codes = ["200"]
    }
  }
}
