locals {
  #default_startup_script = "${path.module}/../custom/common_startup.sh"
  jenkins_pub_key_content = file(var.jenkins_ssh_key)
  #metadata_startup_script = var.start_up_script != null ? file("${path.root}/${var.start_up_script}") : null
  metadata = {
serial-port-enable = var.serial-port-enable  
enable-osconfig = true
enable-oslogin = true
#ssh-keys = "sakrd7873:${file("./keys/gcp-public-sakrd-key.txt")}"
startup-script = <<-EOS
#!/usr/bin/env bash
#set -x
# START COMMON SCRIPT
${file("${path.module}/../custom/common_startup.sh")}
# START STARTUP SCRIPT
${var.start_up_script != null ? file(var.start_up_script) : ""}
# BUCKET Mounts
${var.gcsfuse_mount_script}
# END STARTUP SCRIPT
# Load Jenkins ssh key
${templatefile("${path.module}/../custom/jenkins_user_script.sh.tpl", {jenkins_pub_key_content = local.jenkins_pub_key_content})}
EOS
  }
}

resource "google_compute_instance" "instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.instance_zone
  tags         = ["environment-${var.environment}"]
  deletion_protection = var.deletion_protection
 

  allow_stopping_for_update = true

  labels = {
    "environment" = var.environment
  }

  boot_disk {
    auto_delete = var.bootdisk_auto_delete

    initialize_params {
      image = var.instance_image
      #image           = var.instance_snapshot == "" ? var.instance_image : null
      type  = var.boot_disk_type
    }
  }
  
  
    lifecycle {
      # prevent_destroy = true ### it's comman for all env
      # Prevent destroy only in PRD
      # prevent_destroy = var.environment == "prd"
      ignore_changes = [
    attached_disk, 
    key_revocation_action_type,
    # metadata
     ]
    }
  

  network_interface {
    subnetwork = var.subnet_name
    access_config {}            # this line is what creates external IP
  }

service_account {
  email = var.email
  scopes = var.scopes
}

# metadata = {
#     ssh-keys = "ahilkavi:${file("./keys/gcp-public-ahilkavi-key.txt")}"
#   }

metadata = local.metadata

  # metadata_startup_script = file("${path.module}/startup.sh")
  # metadata_startup_script = file(var.start_up_script)
  # metadata_startup_script = var.start_up_script != null ? file(var.start_up_script) : file(local.default_startup_script)
  # metadata_startup_script = var.start_up_script != null ? file(var.start_up_script) : null
}

# resource "google_os_login_ssh_public_key" "default" {
#   user = "sakrd-7873@sakrd-492305.iam.gserviceaccount.com"
#   key  = file("./keys/gcp-public-sakrd-key.txt")
# }