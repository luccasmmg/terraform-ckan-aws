resource "aws_ecr_repository" "ckan_ecr" {
  name                 = "smckan"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}