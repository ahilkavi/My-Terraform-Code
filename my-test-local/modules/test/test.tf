resource "local_file" "test_paths" {
  filename = "${path.root}/${var.filename}"
  content  = <<EOT
${var.message}
path.module = ${path.module}
path.cwd    = ${path.cwd}
path.root   = ${path.root}
EOT
}
