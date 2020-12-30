terraform {
    required_providers {
        digitalocean = {
            source  = "digitalocean/digitalocean"
            version = "2.3.0"
        }
    }
}

# Variables
variable "do_token" {}
variable "pvt_key" {}


# Use the DO_PAT token (see ~/.secrets file)
provider "digitalocean" {
    token = var.do_token
}

# Add SSH KEY to all new VMs
data "digitalocean_ssh_key" "andrewpearson" {
    name = "andrewpearson@wintermute.lan"
}