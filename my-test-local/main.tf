module "file_creator" {
  source = "./modules/test"
  filename = var.filename
  message = var.message
}
