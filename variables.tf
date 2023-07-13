variable "domain" {
  type     = string
  nullable = false
}

variable "hetznercloud_api_token" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "hetznercloud_servers" {
  type = map(object({
    location        = string
    type            = string
    cloud_init_file = optional(string)
    volume_id       = optional(number)
  }))
  nullable = false
}

variable "cloudflare_api_token" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "cloudflare_account_id" {
  type     = string
  nullable = false
}

variable "cloudflare_zone_id" {
  type     = string
  nullable = false
}

variable "ssh_public_key_file" {
  type     = string
  nullable = false
}

variable "ssh_private_key_file" {
  type     = string
  nullable = false
}
