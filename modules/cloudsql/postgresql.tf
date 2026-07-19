# resource "tls_private_key" "odb_ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "_#-"
}

resource "google_secret_manager_secret" "sql_dba_credentials_secret" {

  secret_id = var.cloud_sql_instance.instance_secrets

  replication {
    user_managed {
      replicas {
        location = "asia-south1"
      }
      replicas {
        location = "asia-south2"
      }
    }
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "google_secret_manager_secret_version" "sql_credentials_secret_version" {
  depends_on = [ google_secret_manager_secret.sql_dba_credentials_secret, 
  random_password.sql_admin_password ]
  secret      = google_secret_manager_secret.sql_dba_credentials_secret.id
  #secret_data = "export SQL_ADMIN_PASSWORD='${random_password.sql_admin_password.result}'"
  secret_data = random_password.sql_admin_password.result

  # lifecycle {
  #   prevent_destroy = true
  # }
  
 }

# Cloud SQL PostgreSQL Instance

locals {
  required_apis = [
    "cloudresourcemanager.googleapis.com",
    "sqladmin.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "vpcaccess.googleapis.com",
  ]
}

resource "google_project_service" "enable_apis" {
  #count     = var.create_db_instance ? 1 : 0
  #for_each           = var.create_db_instance ? toset(local.required_apis) : toset([])
  for_each           = toset(local.required_apis)
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

# resource "google_compute_global_address" "private_ip_alloc" {
#  # count         = var.create_db_instance ? 1 : 0
#   name          = var.cloud_sql_instance.ip_range
#   purpose       = "VPC_PEERING"
#   address_type  = "INTERNAL"
#   prefix_length = 16
#   network       = var.vpc_path_name
# }

# resource "google_service_networking_connection" "private_vpc_connection" {
#  # count                   = var.create_db_instance ? 1 : 0
#   network                 = var.vpc_path_name
#   service                 = "servicenetworking.googleapis.com"
#   reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]

#   depends_on = [google_compute_global_address.private_ip_alloc]
# }

resource "google_sql_database_instance" "postgres" {
  #depends_on = [google_project_service.enable_apis, google_service_networking_connection.private_vpc_connection]
  depends_on = [google_project_service.enable_apis]

 # count            = var.create_db_instance ? 1 : 0
  name             = var.cloud_sql_instance.db_instance_name
  database_version = var.cloud_sql_instance.db_version
  region           = var.region

  lifecycle {}
  

  settings {
    tier      = var.cloud_sql_instance.db_tier
    disk_size = var.cloud_sql_instance.db_disk_size
    disk_type = "PD_SSD"
	availability_type = "ZONAL" # sandbox, no HA
	edition = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.vpc_path_name
      allocated_ip_range = var.cloud_sql_instance.ip_range
    }
    backup_configuration {
      enabled = var.cloud_sql_instance.sandbox_mode ? false : true
    }
  }
  # Deletion protection: disable for sandbox_mode...testing instances
  deletion_protection = var.cloud_sql_instance.sandbox_mode ? false : true

}

# data "google_secret_manager_secret_version" "sql_admin_password" {
#   secret  = "sql-admin-credentials"
#   version = "latest"
# }

resource "google_sql_user" "postgres_admin" {
#  count    = var.create_db_instance ? 1 : 0
  name     = "postgres"
  instance = google_sql_database_instance.postgres.name
  #password = google_secret_manager_secret_version.sql_credentials_secret_version.secret_data
  password = random_password.sql_admin_password.result
  #password = var.postgres_password
}