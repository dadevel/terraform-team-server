variable "domain" {
  type     = string
  nullable = false
}

variable "account_id" {
  type     = string
  nullable = false
}

variable "zone_id" {
  type     = string
  nullable = false
}

variable "ttl" {
  type     = number
  nullable = true
  default  = null
}

variable "ns_records" {
  type     = list(string)
  nullable = false
  default  = []
}

variable "a_records" {
  type     = map(string)
  nullable = false
  default  = {}
}

variable "aaaa_records" {
  type     = map(string)
  nullable = false
  default  = {}
}

variable "sshfp_records" {
  type     = map(object({ algorithm = number, type = number, fingerprint = string }))
  nullable = false
  default  = {}
}

variable "mx_records" {
  type     = map(number)
  nullable = false
  default  = {}
}

variable "spf_record" {
  type     = string
  nullable = false
  default  = "v=spf1 mx -all"
}

variable "dkim_records" {
  type     = map(string)
  nullable = false
  default  = {}
}

variable "dmarc_record" {
  type     = string
  nullable = false
  default  = "v=DMARC1; p=quarantine; adkim=r; aspf=r;"
}
