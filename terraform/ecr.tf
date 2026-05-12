locals {
  repositories = [
    "micro-client",
    "micro-auth",
    "micro-user",
    "micro-email",
    "micro-user-storage",
    "micro-redis-storage"
  ]
}

resource "aws_ecr_repository" "repos" {
  for_each = toset(local.repositories)

  name                 = each.value
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = var.project_name
  }
}