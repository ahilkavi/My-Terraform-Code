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