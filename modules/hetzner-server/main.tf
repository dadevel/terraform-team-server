resource "hcloud_server" "instance" {
  name        = var.hostname
  location    = var.location
  server_type = var.type
  image       = var.os
  ssh_keys    = var.public_keys
  user_data   = var.cloud_init

  connection {
    type        = "ssh"
    host        = self.ipv4_address
    user        = "root"
    private_key = var.private_key
  }

  provisioner "remote-exec" {
    inline = [
      "ssh-keygen -r prefix -f /etc/ssh/ssh_host_ed25519_key.pub > /etc/ssh/sshfp.txt",
    ]
  }
}

resource "hcloud_rdns" "instance" {
  server_id  = hcloud_server.instance.id
  ip_address = hcloud_server.instance.ipv4_address
  dns_ptr    = "${var.hostname}.${var.domain}"
}

data "remote_file" "ssh_fingerprints" {
  depends_on = [hcloud_server.instance]
  conn {
    host        = hcloud_server.instance.ipv4_address
    user        = "root"
    private_key = var.private_key
  }
  path = "/etc/ssh/sshfp.txt"
}

locals {
  ssh_fingerprint_lines = [
    for line in compact(split("\n", data.remote_file.ssh_fingerprints.content)) :
    trimprefix(line, "prefix IN SSHFP ")
  ]
  ssh_fingerprint_blocks = [
    for line in local.ssh_fingerprint_lines : split(" ", line)
  ]
  ssh_fingerprint_objects = [
    for blocks in local.ssh_fingerprint_blocks :
    {
      algorithm   = tonumber(blocks[0])
      type        = tonumber(blocks[1])
      fingerprint = blocks[2]
    }
  ]
  ssh_fingerprint = one([for object in local.ssh_fingerprint_objects : object if object.algorithm == 4 && object.type == 2]) # find sha256 hash of ed25519 key
}

resource "hcloud_volume_attachment" "instance" {
  for_each  = var.volumes
  volume_id = tonumber(each.key)
  server_id = hcloud_server.instance.id
  automount = true
}
