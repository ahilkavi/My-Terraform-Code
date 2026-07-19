terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.48.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = "./keys/my-gcp-key.json"
}