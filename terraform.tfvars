vpc_name           = "sakrd"
vpc_path_name      = "projects/sakrd-492305/global/networks/sakrd"
subnet_name        = "sakrd-subnet"
/* vpc_id               = "gwcm-dev-sharedsvc-spoke-vpc" */
instance_zone = "asia-south1-c"
region        = "asia-south1"
project_id    = "sakrd-492305"
email         = "sakrd-7873@sakrd-492305.iam.gserviceaccount.com"
scopes        = ["https://www.googleapis.com/auth/cloud-platform", "https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_write"]

##
## Environment VMs List
##
env_vm_list = [
  # {
  #   description         = "terraform-test-vm"
  #   instance_name       = "first-vm1"
  #   custom              = "e2-medium"
  #   instance_cores      = "4"
  #   instance_mem        = "4096"
  #   instance_image      = ""
  #   instance_tags       = ["test-vm"]
  #   deletion_protection = false
  #   auto_delete         = true
  #   #boot_disk_type      = "pd-balanced"
  #   start_up_script     = "modules/custom/startup.sh"
  #   #subnetwork_range_name = ""
  #   environment = "prd"
  #   serial-port-enable = true
  # },
  # {
  #   description         = "terraform-test-vm"
  #   instance_name       = "cgi-test-vm1-renamed1"  ##old name "cgi-test-vm1"
  #   custom              = "e2-medium"
  #   machine_type        = "e2-medium"
  #   instance_cores      = "2"
  #   instance_mem        = "4096"
  #   instance_image      = "centos-stream-9"
  #   instance_tags       = ["test-vm"]
  #   deletion_protection = false
  #   auto_delete         = true
  #   boot_disk_type      = "pd-balanced"
  #   start_up_script     = "modules/custom/startup.sh"
  #   #subnetwork_range_name = ""
  #   environment = "prd"
  # },
  #  {
  #     description         = "terraform-test-vm"
  #     instance_name       = "cgi-test-renamed"
  #     custom              = "e2-medium"
  #     machine_type        = "e2-medium"
  #     instance_cores      = "2"
  #     instance_mem        = "4096"
  #     instance_image      = "centos-stream-9"
  #     instance_tags       = ["test-vm"]
  #     deletion_protection = false
  #     auto_delete         = true
  #     boot_disk_type      = "pd-balanced"
  #     start_up_script     = "modules/custom/startup.sh"
  #     #subnetwork_range_name = ""
  #     environment = "prd"
  #   },
  # {
  #   description         = "terraform-test-vm"
  #   instance_name       = "first-vm2"
  #   custom              = "e2-medium"
  #   machine_type        = "e2-medium"
  #   instance_cores      = "2"
  #   instance_mem        = "4096"
  #   instance_image      = "centos-stream-9"
  #   instance_tags       = ["test-vm2"]
  #   deletion_protection = false
  #   auto_delete         = true
  #   boot_disk_type      = "pd-balanced"
  #   environment         = "dev"
  #   start_up_script     = "modules/custom/startup1.sh"
  #   #subnetwork_range_name = ""
  # },

  # {
  #   description         = "terraform-test-vm"
  #   instance_name       = "first-vm3"
  #   custom              = "e2-medium"
  #   machine_type        = "e2-medium"
  #   instance_cores      = "2"
  #   instance_mem        = "4096"
  #   instance_image      = "centos-stream-9"
  #   instance_tags       = ["test-vm3"]
  #   deletion_protection = false
  #   auto_delete         = true
  #   boot_disk_type      = "pd-balanced"
  #   environment         = "uat"
  #   serial-port-enable = true
  #   #subnetwork_range_name = ""
  # },
  # {
  #   description         = "terraform-test-vm"
  #   instance_name       = "my-test-vm"
  #   custom              = "e2-medium"
  #   machine_type        = "e2-medium"
  #   instance_cores      = "2"
  #   instance_mem        = "4096"
  #   instance_image      = "ubuntu-minimal-2504-plucky-amd64"
  #   instance_tags       = ["test-vm4"]
  #   deletion_protection = false
  #   auto_delete         = true
  #   boot_disk_type      = "pd-balanced"
  #   environment         = "uat"
  #   #start_up_script     = ""
  #   #subnetwork_range_name = ""
  # },
  #  {
  #   description         = "terraform-test-vm"
  #   instance_name       = "first-vm4"
  #   custom              = "e2-medium"
  #   machine_type        = "e2-medium"
  #   instance_cores      = "2"
  #   instance_mem        = "4096"
  #   instance_image      = "centos-stream-9"
  #   instance_tags       = ["test-vm4"]
  #   deletion_protection = false
  #   auto_delete         = true
  #   boot_disk_type      = "pd-balanced"
  #   environment         = "uat"
  #   start_up_script     = "modules/custom/startup3.sh"
  #   #subnetwork_range_name = ""
  # },
  #  {
  #   description         = "my-new-vm1"
  #   instance_name       = "sakrd"
  #   custom              = "e2-medium"
  #   machine_type        = "e2-medium"
  #   instance_cores      = "2"
  #   instance_mem        = "4096"
  #   instance_image      = "debian-12-bookworm-v20250910"
  #   instance_tags       = ["test-vm4"]
  #   deletion_protection = false
  #   auto_delete         = true
  #   boot_disk_type      = "pd-balanced"
  #   environment         = "uat"
  #   start_up_script     = "modules/custom/startup3.sh"
  #   #subnetwork_range_name = ""
  # }
  # {
  #   description         = "terraform-test-vm"
  #   instance_name       = "ahilkavi"
  #   custom              = "e2-medium"
  #   #machine_type        = "e2-medium"
  #   instance_cores      = "4"
  #   instance_mem        = "4096"
  #   instance_image      = "centos-stream-9"
  #   instance_tags       = ["test-vm4"]
  #   deletion_protection = false
  #   auto_delete         = true
  #   boot_disk_type      = "pd-balanced"
  #   environment         = "uat"
  #   start_up_script     = "modules/custom/startup3.sh"
  #   #subnetwork_range_name = ""
  # }
]

cloud_storage_buckets = [
  # {
  #   description            = "my-first-bucket"
  #   bucket_name            = "cgi-test-bucket"
  #   bucket_storage_class   = "STANDARD"
  #   bucket_availability    = "asia-south1"
  #   hierarchical_namespace = "true"
  # },
  # {
  #   description          = "my state file bucket"
  #   bucket_name          = "my-new-project-471507-state-bucket"
  #   bucket_storage_class = "STANDARD"
  #   bucket_availability  = "asia-south1"
  #   hierarchical_namespace = "false"
  #   bucket_retention_policy = 1  ###In multiple of 5 seconds..here value is 5secs
  #  },
  #  {
  #   description          = "my state file bucket"
  #   bucket_name          = "my-new-project-471507-statefile-bucket"
  #   bucket_storage_class = "STANDARD"
  #   bucket_availability  = "asia-south1"
  #   hierarchical_namespace = "true"
  #  }
  #  {
  #   description            = "my-cute-bucket"
  #   bucket_name            = "cgi-cute-bucket"
  #   bucket_storage_class   = "STANDARD"
  #   bucket_availability    = "asia-south1"
  #   hierarchical_namespace = "false"
  #   bucket_retention_policy = 7

  # }
  # {
  #   description             = "mi prod inbound bucket"
  #   bucket_name             = "sftp-mi-prd-inbound-bucket"
  #   bucket_storage_class    = "STANDARD"
  #   bucket_availability     = "asia-south1"
  #   hierarchical_namespace  = true
  # }
]

gcsfuse_mounts = [
  {
    description = "bucket for cgi-test-vm1"
    bucket_name = "cgi-test-bucket"
    instance_name = "cgi-test-vm1"
    mount_point = "/cs-shared"
    user_owner = "tamgr"
  },
  {
    description = "bucket for first-vm1"
    bucket_name = "cgi-test-bucket"
    instance_name = "first-vm1"
    mount_point = "/cs-shared"
    user_owner = "tamgr"
  }
  ]

# variables for CloudSQL instances
# db_instance_name   = "test-sql"
# db_tier            = "db-custom-2-8192" #custom only availabe in Enterprise Edition, apart from that we have to put like this "db-perf-optimized-N-*"
# db_disk_size       = 10
# #postgres_password  = "Admin@12345"
# db_version         = "POSTGRES_17"
# sandbox_mode       = true  # if false, then it will be Prod
# create_db_instance = true # true, create instance. false, delete instance and all resources related to instance

## variables for CloudSQL instances
# Variables for Cloud SQL PostgreSQL instances
cloud_sql_instances = [
  {
    db_instance_name   = "sakrd-sql"
    db_tier            = "db-custom-2-8192" # Custom tiers are available only with Enterprise Edition
    db_disk_size       = 10
    db_version         = "POSTGRES_17"
    sandbox_mode       = true   # false = Production
    create_db_instance = false   # true = Create, false = Destroy the instance
    ip_range           = "ahilkavi-range"
    instance_secrets   = "sakrd-sql-crds"

    # Optional. If omitted, a random password will be generated.
    # postgres_password = "Admin@12345"
  },
  {
  db_instance_name   = "cgi-sql"
    db_tier            = "db-custom-2-8192" # Custom tiers are available only with Enterprise Edition
    db_disk_size       = 10
    db_version         = "POSTGRES_17"
    sandbox_mode       = true   # false = Production
    create_db_instance = false   # true = Create, false = Destroy the instance
    ip_range           = "cgi-range"
    instance_secrets   = "cgi-sql-creds"

    # Optional. If omitted, a random password will be generated.
    # postgres_password = "xxxx"
  }
]
##
## ODB NETWORK
##
# odb_network = {
#     network = {
#       name        = "odb-network"
#       display_name = "ODB Network"
#       project     = "sakrd-492305"
#       location    = "asia-south1"
#       vpc_self_link = "projects/sakrd-492305/global/networks/sakrd"
#     }
#     subnet = {
#       name         = "odb-subnet"
#       display_name = "ODB Subnet"
#       cidr         = "10.130.34.0/24"
#     }
# }

##
## CLOUD FILESTORE(NFS)
##
# cloud_filestore = [
#     {
#      description     = "my-own-filestore"
#      name            = "sakrdfilestore"
#      fileshare_name  = "sakrd_filestore"  ###max 16 chars
#      size            = 1024
#      tier            = "BASIC_HDD"  ###ZONAL ##it's provide 9000 iops
#      region          = "asia-south2"
#      instance_zones  = "asia-south2-b"
#      ip_range_restrictions       = [ "10.0.0.0/24", "10.0.1.0/24" ]
#      #reserved_ip_range       = "sakrdfilestore-ip-range"
#      vpc_name = "sakrd"
# 	 perf_iops = 8000
# 	 protocol = "NFS_V3"
#    }
# ]
# # private ip allocate and private connection create variables
# filestore_name = "sakrdfilestore"
# ip_address = "10.130.37.0"
# prefix_length = "24"
# network_project_id = "sakrd-492305"
