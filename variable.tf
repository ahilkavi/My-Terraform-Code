# Defines the project ID where the instances will be created.
variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project."
}

# variable "serial-port-enable" {
#   type    = bool
#   default = false
# }

variable "network_project_id" {
  description = "ID of the project where the network/VPC is located"
  type        = string
  default     = "your-network-project-id" # Replace with your desired default value
}

variable "region" {
  type        = string
  description = "Gcp Region"
}

# Defines a list of availability zones where the instances will be distributed.
variable "instance_zone" {
  type        = string
  description = "A list of availability zones where the instances will be distributed. Each instance will be assigned to a zone from this list."
}

# Defines the name of the VPC network where the instances will be deployed.
variable "vpc_name" {
  type        = string
  description = "The name of the VPC network where the instances will be deployed."
}

# Defines the name of the subnet to attach the instances to.
variable "subnet_name" {
  type        = string
  description = "The name of the subnet to attach the instances to."
}

# variable "boot_disk_type" {
#   type        = string
#   description = "type of the Boot disk"
#   default     = "pd-standard"
# }

# Defines the requirements for application server VMs.
variable "env_vm_list" {
  description = "Defines the requirements for application server VMs."
  type = list(object({
    description         = string
    instance_name       = string # Host name 
    instance_cores      = number
    instance_mem        = number
    machine_type        = optional(string)
    instance_zone       = optional(string)
    instance_image      = string # Name of CGI Image Template
    deletion_protection = optional(bool)
    role                = optional(string)
    auto_delete         = optional(bool)
    boot_disk_type      = optional(string, "pd-standard") # pd-standard, pd-ssd, pd-balanced
    alias_ip            = optional(string)
    start_up_script     = optional(string)
    serial-port-enable  = optional(bool)
    custom              = optional(string)
    threads_per_core    = optional(number)
  #  instance_snapshot   = optional(string)
    environment         = string
  }))
}

# # Defines the requirements for cloud storage buckets.
# variable "cloud_storage_buckets" {
#   description = "Defines the requirements for cloud storage."
#   type = list(object({
#     description             = string
#     bucket_name             = string
#     bucket_retention_policy = optional(number) # Retention policy in number days.	
#     bucket_storage_class    = string
#     bucket_availability     = string # The default = REGION. Some buckets will need to be in dual-regions
#     ## We can add additional attributes as needed ...
#   }))
#   default = []
# }


variable "deletion_protection" {
  description = "Enable deletion protection on this instance"
  type        = bool
  default     = false
}

# Defines the environment (e.g., DEV, SIT, UAT, PRD, DR) for the instances.
variable "environment" {
  type        = string
  default     = "prd"
  description = "The environment for the instances."
}

variable "scopes" {
  type = list(string)
}

variable "email" {

}

# Defines the requirements for cloud storage buckets.
variable "cloud_storage_buckets" {
  description = "Defines the requirements for cloud storage."
  type = list(object({
    description             = string
    bucket_name             = string
    bucket_retention_policy = optional(number, 2555) # Retention policy in number days.	(default = 7 years)
    bucket_storage_class    = string
    bucket_availability     = string # The default = REGION. Some buckets will need to be in dual-regions
    hierarchical_namespace  = optional(bool, true)
    ## We can add additional attributes as needed ...
  }))
  default = []
}

###Below the variables for CloudSQL instance_cores
# variable "db_instance_name" {
#   type        = string
#   description = "Cloud SQL PostgreSQL instance name"
#}

# variable "db_tier" {
#   type        = string
#   description = "Machine type"
# }

# variable "db_disk_size" {
#   type        = number
#   description = "Disk size in GB"
# }

# variable "postgres_password" {
#   type        = string
#   description = "Password for default postgres superuser"
#   sensitive   = true
#   default = ""
# }

# variable "db_version" {
#   type        = string
#   description = "PostgreSQL version for Cloud SQL"
#   default     = "POSTGRES_15"
# }

variable "vpc_path_name" {
  type        = string
  description = "vpc full path(sellink)"
}

# variable "create_db_instance" {
#   type    = bool
#   default = true
# }

# variable "sandbox_mode" {
#   type        = bool
#   description = "this is for small instance for testing"
#   default     = true
# }

variable "jenkins_ssh_key" {
  description = "Public key content for Jenkins user"
  type        = string
  default     = "./keys/jenkins_id_rsa.pub"
}

variable "serial-port-enable" {
  type = string
  default = false
}

variable "gcsfuse_mounts" {
  description = "Define the mount points storage on vms"
  type = list(object({
    description   = string
    bucket_name   = string
    mount_point   = string
    instance_name = string
    user_owner    = string
  }))
  default = []
}

variable "odb_network" {
  description = "ODB network and subnet configuration"

  type = object({
    network = object({
      name         = string
      display_name = string 
      project      = string
      location     = string
      vpc_self_link      = string
    })

    subnet = object({
      name         = string
      display_name = string
      cidr         = optional(string, "10.130.34.0/24")
    })
  })
   default = null
  
}

####Filestore instances and mounts
# Defines the requirements for filestore storage.
variable "cloud_filestore" {
  description = "Defines the requirements for filestore storage."
  type = list(object({
    description = string
    name        = string
    size        = number # Size of the filestore in GB.
    tier        = string
    protocol = optional (string , "NFSv3")
    perf_iops = optional (number, null)
    location = optional(string, null)
    ip_range_restrictions = list (string)
    fileshare_name = string
    instance_zones = string
    reserved_ip_range = optional(string)
  }))
  default = []
}

# Defines the mounting points for filestore on VMs.
variable "filestore_mount_points" {
  description = "The mounting points: VM, Src-Path, Dest-path"
  type = list(object({
    description = string
    hostnames   = string # List of app servers to be mounted on.
    src_path    = string
    dest_path   = string
  }))
  default = []
}

## private ip allocate and private connection create variables
variable "ip_address" { 
  type = string 
  default     = "" 
  }
variable "prefix_length" { 
  type = string 
  default     = null
  }
variable "filestore_name" { 
  type = string 
  default     = ""
  }

variable "cloud_sql_instances" {
  description = "List of Cloud SQL PostgreSQL instances"

  type = list(object({
    db_instance_name   = string
    db_tier            = string
    db_disk_size       = number
    db_version         = string
    instance_secrets   = string
    sandbox_mode       = bool
    create_db_instance = bool
    postgres_password  = optional(string)
    ip_range           = optional(string)
  }))

  default = []
}