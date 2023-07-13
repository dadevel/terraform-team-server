output "domain" {
  value = var.domain
}

output "hostname" {
  value = var.hostname
}

output "fqdn" {
  value = "${var.hostname}.${var.domain}"
}

output "ipv4_address" {
  value = hcloud_server.instance.ipv4_address
}

output "ipv6_address" {
  value = hcloud_server.instance.ipv6_address
}

output "ssh_fingerprint" {
  value = local.ssh_fingerprint
}
