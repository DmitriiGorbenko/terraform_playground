resource "proxmox_vm_qemu" "centOS" {
  for_each     = var.vms  # Используем for_each для создания ВМ
  name         = each.value.name  # Уникальное имя для каждой ВМ
  target_node  = "pve"
  agent        = 1
  cpu          = "host"
  cores        = each.value.cores
  memory       = each.value.memory
  boot         = "order=scsi0"
  clone        = "centOS1"
  scsihw       = "virtio-scsi-single"
  onboot       = true
  vm_state    = "running"
  automatic_reboot = true

  os_type = "cloud-init"
  ipconfig0 = "ip=dhcp"

  ciuser     = "root"
  cipassword = "admin123"
  sshkeys    = var.ssh_public_key

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "local-lvm"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = each.value.disk_size 
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }


  # Настройка подключения для remote-exec
  connection {
    type     = "ssh"
    user     = "root"  # Пользователь для подключения
    private_key = file("~/.ssh/id_rsa")  # Приватный SSH-ключ
    host     = self.default_ipv4_address  # IP-адрес ВМ
    host_key    = ""  # Явно отключаем проверку ключа хоста
  }


  # Задание hostname через cloud-init
  provisioner "remote-exec" {
    inline = [
      "echo 'hostname: ${each.value.name}' > /etc/cloud/cloud.cfg.d/99_hostname.cfg",
      "cloud-init clean && cloud-init init"
    ]
  }

}
resource "null_resource" "generate_ansible_inventory" {
  triggers = {
    vm_ips = join(",", [for vm in proxmox_vm_qemu.centOS : "${vm.name}=${vm.default_ipv4_address}"])
  }

  provisioner "local-exec" {
    command = <<-EOT
      echo "[vms]" > "$PWD/inventory.ini"
      echo "${join("\n", [for vm in proxmox_vm_qemu.centOS : "${vm.name} ansible_host=${vm.default_ipv4_address}"])}" >> "$PWD/inventory.ini"
    EOT
    interpreter = ["/bin/zsh", "-c"]
  }
}