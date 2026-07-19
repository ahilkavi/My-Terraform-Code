variable "instance_name" {
  type        = string
  description = "instance_name"
}
variable "machine_type" {
  description = "Machine type for the Google Compute Engine instance"
}
variable "start_up_script" {
  type  = string
  default = null

}
# Defines a list of availability zones where the instances will be distributed.
variable "instance_zone" {
  type        = string
  description = "A list of availability zones where the instances will be distributed. Each instance will be assigned to a zone from this list."
}
variable "instance_image" {
  type        = string
  description = "instance_image"
}
variable "boot_disk_type" {
  type = string
  description = "type of the Boot disk"
  default = "pd-standard"
}
# Defines the name of the subnet to attach the instances to.
variable "subnet_name" {
  type        = string
  description = "The name of the subnet to attach the instances to."
}
 
 # Define the environment
 variable "environment" {
    type    = string
    default = "prd"
    description = "The name of the vm env"
  }

  variable "bootdisk_auto_delete" {

}
variable "deletion_protection" {

}

variable "email" {

}
variable "scopes" {
  type = list(string)
}

# variable "jenkins_pubkey" {
#   description = "Public key content for Jenkins user"
#   type        = string
#   default     = file("${path.module}/../keys/jenkins_id_rsa.pub")
# }

variable "jenkins_ssh_key" {
  description = "Public key content for Jenkins user"
  type        = string
  default     = "../keys/jenkins_id_rsa.pub"
 }

variable "serial-port-enable" {
  type = string
 } 

 variable "gcsfuse_mount_script" {
  type = string
  default = ""
}

variable "instance_cores" {
  type        = number
  description = "instance_cores"
}

variable "instance_mem" {
  type        = number
  description = "instance_mem"
}
# variable "instance_snapshot" {
#   description = "Optional snapshot for boot disk restore"
#   type        = string
#   default     = ""
# }