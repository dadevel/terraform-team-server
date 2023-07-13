terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    remote = {
      source = "tenstad/remote"
    }
  }
  required_version = ">= 1.1.9"
}

provider "hcloud" {
  token = var.hetznercloud_api_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "remote" {
}
