resource "google_storage_bucket" "buckets" {
 for_each = { for bkt in var.cloud_storage_buckets : bkt.bucket_name => bkt }
  name          = each.value.bucket_name
  location      = each.value.bucket_availability
  storage_class = each.value.bucket_storage_class

  uniform_bucket_level_access = true

  
  force_destroy = true

  lifecycle {
    #prevent_destroy = true #it's not allow to destroy the buckets
    ignore_changes = [
      #retention_policy
      ]
  }
 

  # versioning {
  #   enabled = true
  # }

  dynamic "retention_policy" {
    for_each = each.value.hierarchical_namespace != true? [1] : []
    content {
      #retention_period = each.value.bucket_retention_policy * 24 * 60 * 60
      retention_period = each.value.bucket_retention_policy * 5
    }  
   }

  # retention_policy {
  #   retention_period = each.value.bucket_retention_policy
  # }

  hierarchical_namespace {
    enabled = each.value.hierarchical_namespace
  }

  labels = {
    resource-name = each.value.bucket_name
  }
}