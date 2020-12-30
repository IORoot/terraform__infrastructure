# ┌────────────────────────────────────────────────────────┐
# │                                                        │
# │                                                        │
# │                        Build VM                        │
# │                                                        │
# │                        test-vm                         │
# │                                                        │
# │                                                        │
# └────────────────────────────────────────────────────────┘

// API v2 Docs = https://developers.digitalocean.com/documentation/v2/#images
// sizes       = https://developers.digitalocean.com/documentation/changelog/api-v2/new-size-slugs-for-droplet-plan-changes/
// regions     = https://www.digitalocean.com/docs/platform/availability-matrix/
// images      = https://marketplace.digitalocean.com/apps/wordpress
resource "digitalocean_droplet" "www-1" {
    image = "wordpress-20-04"
    name = "test-vm"
    region = "LON1"
    size = "s-1vcpu-1gb"
    private_networking = true
    ssh_keys = [
        data.digitalocean_ssh_key.andrewpearson.id
    ]


    # This allows SSH connection to the VM for Terraform
    connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        private_key = file(var.pvt_key)
        timeout = "2m"
    }

    # Run these commands (install puppet?)
    provisioner "remote-exec" {
        inline = [
            "export PATH=$PATH:/usr/bin",
            # Alias
            "alias ll=\"ls -la\"",
            # # install nginx
            # "sudo apt-get update",
            # "sudo apt-get -y install nginx",
        ]
    }

}

