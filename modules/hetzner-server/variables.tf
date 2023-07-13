variable "domain" {
  type     = string
  nullable = false
}

variable "hostname" {
  type     = string
  nullable = false
}

variable "location" {
  type     = string
  nullable = false
}

variable "type" {
  type     = string
  nullable = false
}

variable "os" {
  type     = string
  nullable = false
  default  = "ubuntu-22.04"
}

variable "public_keys" {
  type     = list(string)
  nullable = false
  default  = []
}

variable "private_key" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "cloud_init" {
  type     = string
  nullable = true
  default  = null
}

variable "volumes" {
  type     = set(string)
  nullable = false
  default  = []
}
