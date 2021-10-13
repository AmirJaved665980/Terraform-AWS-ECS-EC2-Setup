output "ecr_image_reverse_proxy_url" {
  value = aws_ecr_repository.ecr_image_reverse_proxy.repository_url
}
output "ecr_image_backend_url" {
  value = aws_ecr_repository.ecr_image_backend.repository_url
}
output "ecr_image_frontend_url" {
  value = aws_ecr_repository.ecr_image_frontend.repository_url
}

output "app_url" {
  value = aws_elb.lb.dns_name
}
output "ecs_family" {
  value = aws_ecs_task_definition.ecs_task_definition.family
}
output "ecs_cluster" {
  value = aws_ecs_cluster.ecs-cluster.name
}
output "ecs_service" {
  value = aws_ecs_service.ecs-service.name
}
