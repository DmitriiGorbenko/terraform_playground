variable "proxmox_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "The token ID for the Proxmox API"
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "The token secret for the Proxmox API"
  type        = string
  sensitive   = true
}

variable "storage_name" {
  description = "The name of the storage to use for the VM"
  type        = string
}

variable "vms" {
  type = map(object({
    name        = string
    cores       = number
    memory      = number
    disk_size   = string
  }))

  default = {
    "master-1" = {
      name      = "master-1"
      cores     = 4
      memory    = 4096
      disk_size = "32G"
    },
    "master-2" = {
      name      = "master-2"
      cores     = 4
      memory    = 4096
      disk_size = "32G"
    },
    "master-3" = {
      name      = "master-3"
      cores     = 4
      memory    = 4096
      disk_size = "32G"
    }
  
    "worker-1" = {
      name      = "worker-1"
      cores     = 6
      memory    = 4096
      disk_size = "32G"
    }
    "worker-2" = {
      name      = "worker-2"
      cores     = 6
      memory    = 4096
      disk_size = "32G"
    }

    "ingress" = {
      name      = "ingress"
      cores     = 2
      memory    = 2048
      disk_size = "32G"
    }
  }  
}

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDv7f1rS6SZJMLBDB8t1J1ijBBfMPvM7KHH0zeT8TeV3OG4WrnG/hf4yueeTy0NcAyXJL2TvBOEfdPBfILJiSqcoQVkvpxyFSLNli6A5TpJHGkZw1fRg9AiMZaEVnVR1KsyEeG3PbxU0VS1BKXMKDGBg9xOA9isIdRmO8QuQflcz2IuXCSf0S3Q55GoRxNITk3VhLtFlzWs+lPDgFp2oGL6hKlM0O5D33ySCIxdDiFeAa4HbGUrrH/1azCYUDw1R3j4Cm7DDyOCFYO4+zLXi2wuzHkX5eREnzkLjt9e3rEpMPqNmXoUnbJOO6ioAGykilZIYpV5Stjp1U+uFoNWDuCjjH7yqcuAaMvszb6LNCbYd0viLa5/AiXtrx0lC1GYvFVaBFydxz6J2sYnZSAkXkF+ZyY5v1YVwegSCWGmkF3dfbJKDtcHi5MIWaLiUyVRXmZ74RjKGDzGv2IX0989zEtYJcnwjKPCXWL9SYFwlgHZcfJXvxdM3h29nEFhmenLwQ16J60IEpn+lt2nu+bzwdUt4dFZPNJ8A+ra5RXr1AQ3NjdB0riqSDVthRBn1PX3KbcQWCB5y+v4M81zchBZaCaZv4mA3bkdas+qIP0ZgcaL2SSZIzpBTc3GpncMjoBLMvHxA7VkRKiz3XRQq8SriG2OwqaLKpqum/kG0Feb5xK8Q== kommanderspock@gmail.com"
}