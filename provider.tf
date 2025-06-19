terraform {
    required_providers {
        proxmox = {
            source = "Telmate/proxmox"
            version = "3.0.1-rc8"
        }
    }
}

variable "proxmox_api_url" {
    type = string
}
variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}
variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}
provider "proxmox" {
    pm_api_url = var.proxmox_api_url
    pm_api_token_id = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret
    pm_tls_insecure = true
#    pm_tls_insecure = false
}

variable "vm_count" {
    type        = number
    default     = 2 # Change this
}

variable "vm_name_prefix" {
    type        = string
    default     = "terraform" # Change this
}

variable "base_vmid" {
    description = "base_vmid + index"
    type        = number
    default     = 1010010 # Change this
}

variable "base_ip" {
    type        = string
    default     = "10.10.10" # Change this
}

variable "ip_start" {
    type        = number
    default     = 10 # Change this
}