############## create ecr repos ###########
resource "aws_ecr_repository" "ecr_image_frontend" {
  name = "frontend"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr_image_backend" {
  name = "backend"
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "ecr_image_reverse_proxy" {
  name = "reverse_proxy"
  image_scanning_configuration {
    scan_on_push = true
  }
}


#### ECR Images retention
resource "aws_ecr_lifecycle_policy" "frontend" {
  repository = aws_ecr_repository.ecr_image_frontend.name
 
  policy = jsonencode({
   rules = [{
     rulePriority = 1
     description  = "keep last 10 images"
     action       = {
       type = "expire"
     }
     selection     = {
       tagStatus   = "any"
       countType   = "imageCountMoreThan"
       countNumber = 10
     }
   }]
  })
}

resource "aws_ecr_lifecycle_policy" "backend" {
  repository = aws_ecr_repository.ecr_image_backend.name
 
  policy = jsonencode({
   rules = [{
     rulePriority = 1
     description  = "keep last 10 images"
     action       = {
       type = "expire"
     }
     selection     = {
       tagStatus   = "any"
       countType   = "imageCountMoreThan"
       countNumber = 10
     }
   }]
  })
}

resource "aws_ecr_lifecycle_policy" "reverse_proxy" {
  repository = aws_ecr_repository.ecr_image_reverse_proxy.name
 
  policy = jsonencode({
   rules = [{
     rulePriority = 1
     description  = "keep last 10 images"
     action       = {
       type = "expire"
     }
     selection     = {
       tagStatus   = "any"
       countType   = "imageCountMoreThan"
       countNumber = 10
     }
   }]
  })
}