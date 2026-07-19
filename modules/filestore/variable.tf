
variable "cloud_filestore" {
  description = "List of cloud filestore configurations"
  type = list(object({
    description = string
    name        = string
    size        = number
    tier        = optional(string)
    protocol = optional (string , "NFSv3")
    perf_iops = optional (number, null)
    location = optional(string, null)
    ip_range_restrictions = list (string)
    fileshare_name = string
    instance_zones = string
    reserved_ip_range = optional(string)
      }))
}

variable "vpc_name" { type = string }
variable "project_id" {type = string }
variable "network_project_id" { type = string }
variable "ip_address" { type = string }
variable "prefix_length" { type = string }
variable "filestore_name" { type = string }