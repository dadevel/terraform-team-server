resource "hcloud_ssh_key" "terraform" {
  name       = "terraform"
  public_key = file(var.ssh_public_key_file)
}

module "managed_servers" {
  for_each    = var.hetznercloud_servers
  source      = "./modules/hetzner-server"
  domain      = var.domain
  hostname    = each.key
  location    = each.value.location
  type        = each.value.type
  public_keys = [hcloud_ssh_key.terraform.id]
  private_key = file(var.ssh_private_key_file)
  cloud_init  = each.value.cloud_init_file == null ? null : templatefile(each.value.cloud_init_file, each.value)
  volumes     = each.value.volume_id == null ? [] : [each.value.volume_id]
}

module "dns_records" {
  source        = "./modules/cloudflare-dns-records"
  account_id    = var.cloudflare_account_id
  zone_id       = var.cloudflare_zone_id
  domain        = var.domain
  a_records     = { for server in module.managed_servers : server.hostname => server.ipv4_address }
  aaaa_records  = { for server in module.managed_servers : server.hostname => server.ipv6_address }
  sshfp_records = { for server in module.managed_servers : server.hostname => server.ssh_fingerprint }
}
