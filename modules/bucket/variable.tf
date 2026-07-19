variable "cloud_storage_buckets" {
  type = list(object({
    description             = string
    bucket_name             = string
    bucket_retention_policy = optional(number, 2555)
    bucket_storage_class    = string
    bucket_availability     = string
    hierarchical_namespace = optional(bool, true)
  }))
}