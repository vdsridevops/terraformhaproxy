resource "google_compute_instance" "vm_instance" {
  name         = "terraform-haproxy"
  machine_type = var.machine_type
  tags         = ["haproxy-http"] 
  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  metadata = {
        startup-script = <<SCRIPT
        echo "ansible123" | passwd --stdin root
        sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        systemctl restart sshd
        SCRIPT
    }

  network_interface {
    network       = "default"
    subnetwork    = "default"
    network_ip    = "10.138.0.13"
    access_config {
    }
  }

  provisioner "local-exec" {
    command = "sshpass -p ansible123 ssh-copy-id root@10.138.0.13 -f -o StrictHostKeyChecking=no"
  }

  provisioner "remote-exec" {
    inline = ["yum install python -y"]

  }
  connection {
    type = "ssh"
    host = "10.138.0.13"
    user = "root"
    password = "ansible123"
  }

}

#resource "google_compute_firewall" "default" {
#  name    = "haproxy-allow-http"
#  network = "self_link"

#  allow {
#    protocol = "tcp"
#    ports    = ["80"]
#  }
#  target_tags = ["haproxy-http"]

#}


