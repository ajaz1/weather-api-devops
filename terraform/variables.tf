variable "hcloud_token" {
  type      = string
  sensitive = true
}

variable "ssh_key_name" {
  type = string
}

variable "location" {
  default = "nbg1"
}

variable "server_type" {
  default = "cx22"
}
