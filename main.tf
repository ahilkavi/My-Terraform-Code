module "provision_env_vms" {
  #depends_on = [google_compute_address.region_ip_address]
  for_each = { for vm in var.env_vm_list : vm.instance_name => vm }

  source = "./modules/compute"
  #project_id            = var.project_id
  environment = each.value.environment != null ? each.value.environment : "prd"
  #network_project_id    = var.network_project_id
  subnet_name   = var.subnet_name
  instance_zone = each.value.instance_zone != null ? each.value.instance_zone : "${var.instance_zone}"
  #vpc_name              = var.vpc_name
  #serial-port-enable    = lookup(each.value, "serial-port-enable", null)
  #region                = var.region
  instance_name = each.value.instance_name
  instance_cores        = each.value.instance_cores
  instance_mem          = each.value.instance_mem
  instance_image       = each.value.instance_image
  start_up_script      = each.value.start_up_script
  bootdisk_auto_delete = lookup(each.value, "auto_delete", true)
  boot_disk_type       = each.value.boot_disk_type != null ? each.value.boot_disk_type : "pd-standard"
  deletion_protection  = lookup(each.value, "deletion_protection", true)
  scopes               = var.scopes
  email                = var.email
  jenkins_ssh_key      = var.jenkins_ssh_key
  serial-port-enable   = lookup(each.value, "serial-port-enable", null)
  machine_type         = each.value.custom != null ? each.value.custom : "custom-${each.value.instance_cores}-${each.value.instance_mem * 1024}-ext"
  gcsfuse_mount_script = <<-EOT
                         %{for mnt in var.gcsfuse_mounts~}
                         %{if mnt.instance_name == each.value.instance_name}
                         sudo mkdir -p ${mnt.mount_point}
                         sudo chown ${mnt.user_owner}:${mnt.user_owner} ${mnt.mount_point}
                         sudo su - ${mnt.user_owner} -c "/usr/local/bin/gcsfuse --implicit-dirs ${mnt.bucket_name} ${mnt.mount_point}"
                         %{endif}
                        %{endfor}
                        EOT
#instance_snapshot      = each.value.instance_snapshot
}

module "storage_bucket" {
  # for_each              = { for bkt in var.cloud_storage_buckets : bkt.bucket_name => bkt }
  source                = "./modules/bucket/"
  cloud_storage_buckets = var.cloud_storage_buckets
}

# module "postgresql" {
#   source             = "./modules/cloudsql/"
#   project_id         = var.project_id
#   region             = var.region
#   vpc_path_name      = var.vpc_path_name
#   db_instance_name   = var.db_instance_name
#   db_version         = var.db_version
#   db_tier            = var.db_tier
#   db_disk_size       = var.db_disk_size
#   create_db_instance = var.create_db_instance
#   postgres_password  = var.postgres_password
#   sandbox_mode       = var.sandbox_mode
# }

module "postgresql" {
  for_each = {for db in var.cloud_sql_instances : db.db_instance_name => db if db.create_db_instance}

  source = "./modules/cloudsql"

  cloud_sql_instance = each.value

  project_id   = var.project_id
  region       = var.region
  vpc_path_name = var.vpc_path_name
}

module "odb" {
  source = "./modules/odb/"
  odb_network = var.odb_network
}

module "filestore" {
  source = "./modules/filestore/"
  cloud_filestore = var.cloud_filestore
  vpc_name        = var.vpc_name
  filestore_name  = var.filestore_name
  prefix_length   = var.prefix_length
  network_project_id = var.network_project_id
  ip_address  = var.ip_address
  project_id = var.project_id
}