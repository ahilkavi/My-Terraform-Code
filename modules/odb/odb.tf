# Create ODB network only if var.odb_network is provided
resource "google_oracle_database_odb_network" "odb_network" {
  for_each = var.odb_network != null ? { "odb" = var.odb_network } : {}

  odb_network_id      = each.value.network.name
  location            = each.value.network.location
  project             = each.value.network.project
  network             = each.value.network.vpc_self_link
  labels = {
    terraform_created = each.value.network.display_name
  }
  deletion_protection = true
}

# Create ODB subnet only if odb_network exists
resource "google_oracle_database_odb_subnet" "odb_subnet" {
  for_each = var.odb_network != null ? { "odb" = var.odb_network } : {}

  odb_subnet_id = each.value.subnet.name
  location      = each.value.network.location
  project       = each.value.network.project
  odbnetwork    = google_oracle_database_odb_network.odb_network[each.key].id
  cidr_range    = coalesce(each.value.subnet.cidr, "10.130.34.0/24")
  purpose       = "CLIENT_SUBNET"
  labels = {
    terraform_created = each.value.subnet.display_name
  }
  deletion_protection = true
}