# terraform {
#   backend "gcs" {
#       bucket  = "my-new-project-471507-statefile-bucket"
#       prefix  = "471507/terraform/state"
#       credentials = "./keys/my-gcp-key.json"
#   }
# }