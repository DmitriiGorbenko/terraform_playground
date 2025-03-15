output "vm_ips" {
  value = {
    for vm in proxmox_vm_qemu.centOS : vm.name => vm.default_ipv4_address
  }
  description = "IP-адреса созданных ВМ"
}