domain = "example.com"

cloudflare_api_token = "examplexxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# see https://developers.cloudflare.com/fundamentals/get-started/basic-tasks/find-account-and-zone-ids/
cloudflare_account_id = "examplexxxxxxxxxxxxxxxxxxxxxxxxx"
cloudflare_zone_id    = "examplexxxxxxxxxxxxxxxxxxxxxxxxx"

hetznercloud_api_token = "examplexxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
hetznercloud_servers = {
  team = {
    location        = "nbg1" # nürnberg
    type            = "cx11"
    cloud_init_file = "./cloud-init.yaml"
    volume_id       = 00000000
  }
}

ssh_private_key_file = "~/.ssh/id_rsa"
ssh_public_key_file  = "~/.ssh/id_rsa.pub"
