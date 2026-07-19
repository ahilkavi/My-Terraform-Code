# data "google_compute_network" "vpc" {
#   name    = var.vpc_name
#   project = var.network_project_id
# }



# Create an IP address
resource "google_compute_global_address" "filestore_ip_range" {
  count = var.ip_address != "" ? 1 : 0
  name          = "${var.filestore_name}-ip-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.prefix_length != null ? var.prefix_length : 24 # Default value 24
  network       = "projects/${var.network_project_id}/global/networks/${var.vpc_name}"
  #network = data.google_compute_network.vpc.id
  address       = var.ip_address
}

# Create a private connection
resource "google_service_networking_connection" "private_connection" {
  depends_on = [
    google_compute_global_address.filestore_ip_range
  ]
count = var.ip_address != "" ? 1 : 0
  network                 = "projects/${var.network_project_id}/global/networks/${var.vpc_name}"
  #network = data.google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.filestore_ip_range[0].name]
}

# (Optional) Import or export custom routes
resource "google_compute_network_peering_routes_config" "peering_routes" {
  depends_on = [
    google_service_networking_connection.private_connection
  ]
  count = var.ip_address != "" ? 1 : 0
  peering = google_service_networking_connection.private_connection[0].peering
  #network = data.google_compute_network.vpc.id
  network = var.vpc_name

  import_custom_routes = true
  export_custom_routes = true
}


resource "google_filestore_instance" "instance" {
 depends_on = [ google_compute_global_address.filestore_ip_range, 
  google_service_networking_connection.private_connection, google_compute_network_peering_routes_config.peering_routes ]
  for_each = { for fs in var.cloud_filestore : fs.name => fs }

  name     = each.value.name
  location = each.value.instance_zones
  tier     = lookup(each.value, "tier", "BASIC_HDD") # Default value BASIC_HDD
  protocol = each.value.protocol

  
	   
  file_shares {
    capacity_gb = each.value.size
    name = each.value.fileshare_name

    nfs_export_options {
    ip_ranges = each.value.ip_range_restrictions
	  access_mode = "READ_WRITE"
    squash_mode = "NO_ROOT_SQUASH"
    
	  }

  }
  
  # fixed_iops {
  #     max_iops = each.value.perf_iops
	#   }

  networks {
    network = var.vpc_name
    modes   = ["MODE_IPV4"]
    connect_mode = "PRIVATE_SERVICE_ACCESS"
    reserved_ip_range = each.value.reserved_ip_range
  }

  labels = {
    description = each.value.description
    resource-name = each.value.name
  }
}