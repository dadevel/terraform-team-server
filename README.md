# Terraform Team Server

This repo provides Terraform modules and accompanying files to spin up a [Sliver](https://github.com/BishopFox/sliver) team server on [Hetzner](https://hetzner.cloud/) while managing DNS with [Cloudflare](https://cloudflare.com/).

## Setup

1. Manually create a volume at Hetzner to store data you want to keep persistent (will be mounted to `/home/sliver`).
2. Rename [example.tfvars](./example.tfvars) to `terraform.tfvars` and fill out the placeholders.
3. Run `terraform apply`.
4. Connect to your new team server via `ssh -o VerifyHostKeyDNS=yes sliver@team.example.com`.
5. Add the first operator with `sliver-server operator -l team.example.com -n admin`.
6. Perform your operation.
7. Shut everything back down with `terraform destroy`.
