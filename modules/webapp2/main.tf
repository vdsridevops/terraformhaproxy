resource "google_compute_instance" "vm_instance" {
  name         = "terraform-webapp2"
  machine_type = var.machine_type

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
    network_ip    = "10.138.0.12"
    access_config {
    }
  }

  provisioner "local-exec" {
    command = "sshpass -p ansible123 ssh-copy-id root@10.138.0.12 -f -o StrictHostKeyChecking=no"
  }

  provisioner "remote-exec" {
    inline = ["yum install python -y"]

  }
  connection {
    type = "ssh"
    host = "10.138.0.12"
    user = "root"
    password = "ansible123"
  }




}
