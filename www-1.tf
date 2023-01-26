resource "digitalocean_droplet" "www-1" {
  image = "ubuntu-22-04-x64"
  name = "www-1"
  region = "sgp1"
  size = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ercsanchez_dtop.id
  ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    # private_key = file(var.pvt_key) # if ssh key is not passphrase protected, provide file path
    agent = "true" # if ssh key is passphrase protected, terraform cannot unencrypt but unencrypted key is loaded onto ssh-agent and can be provided
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }
}