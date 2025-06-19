resource "proxmox_vm_qemu" "vm_terraform_demo" {
    count = var.vm_count
    name = "${var.vm_name_prefix}-${format("%03d", count.index + 1)}" #require
#    tags = "terraform"
#    desc = "Debian12" #show in proxmox GUI -> Notes
    vmid = var.base_vmid + count.index #require
    target_node = "pve" #require
    clone = "debian-12"
    vm_state = "stopped"   
    full_clone = true
    agent = 1
    os_type = "cloud-init"
    scsihw = "virtio-scsi-pci"
    hotplug = "network,disk,usb,memory"
    numa = true
    cpu_type = "IvyBridge"
#    sockets = 1
#    cores = 1
    memory = 1024 #require
    balloon = 1024 # match memory

    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
        firewall = false
#        tag = 100
    }

    disks {
        scsi {
            scsi30 { #cloudinit disk
                cloudinit {
                    storage = "local"
                }
            }
        }
        virtio {
            virtio0 { #main disk
                disk {
                    backup = true
                    discard = true
                    replicate = true
                    format = "qcow2"
                    size = 8 #require
                    storage = "local" #require
                }
            }
        }
    }

#    ipconfig0 = "ip=dhcp" #for proxmox sdn assign IP from netbox
    ipconfig0 = "ip=${var.base_ip}.${var.ip_start + count.index}/24,gw=10.10.10.1"
    ciuser = "hahaha"
#    cipassword = ""
    ciupgrade = true
    nameserver = ""
    sshkeys = <<EOF
ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    EOF
}