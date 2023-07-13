resource "cloudflare_record" "ns_record" {
  for_each = toset(var.ns_records)
  zone_id  = var.zone_id
  type     = "NS"
  name     = "@"
  value    = each.value
  ttl      = var.ttl
}

resource "cloudflare_record" "a_record" {
  for_each = var.a_records
  zone_id  = var.zone_id
  type     = "A"
  name     = each.key
  value    = each.value
  ttl      = var.ttl
}

resource "cloudflare_record" "aaaa_record" {
  for_each = var.aaaa_records
  zone_id  = var.zone_id
  type     = "AAAA"
  name     = each.key
  value    = each.value
  ttl      = var.ttl
}

resource "cloudflare_record" "sshfp_record" {
  for_each = var.sshfp_records
  zone_id  = var.zone_id
  type     = "SSHFP"
  name     = each.key
  data {
    algorithm   = each.value.algorithm
    type        = each.value.type
    fingerprint = each.value.fingerprint
  }
  ttl = var.ttl
}

resource "cloudflare_record" "mx_record" {
  for_each = var.mx_records
  zone_id  = var.zone_id
  type     = "MX"
  name     = "@"
  value    = "${each.key}.${var.domain}"
  priority = each.value
  ttl      = var.ttl
}

resource "cloudflare_record" "spf_record" {
  count   = length(var.mx_records) > 0 ? 1 : 0
  zone_id = var.zone_id
  type    = "TXT"
  name    = "@"
  value   = jsonencode(var.spf_record)
  ttl     = var.ttl
}

resource "cloudflare_record" "dkim_record" {
  for_each = var.dkim_records
  zone_id  = var.zone_id
  type     = "TXT"
  name     = "${each.key}._domainkey"
  value    = jsonencode(each.value)
  ttl      = var.ttl
}

resource "cloudflare_record" "dmarc_record" {
  count   = length(var.mx_records) > 0 ? 1 : 0
  zone_id = var.zone_id
  type    = "TXT"
  name    = "_dmarc"
  value   = jsonencode(var.dmarc_record)
  ttl     = var.ttl
}
