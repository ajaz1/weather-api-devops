variable "location" {
  type = string
}

variable "server_type" {
  type = string
}

variable "ssh_key_name" {
  type = string
}

variable "hcloud_token" {
  type      = string
  sensitive = true
}
