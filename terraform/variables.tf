variable "aws_region" {
  default = "ap-southeast-1"
}

variable "project_name" {
  default = "scalable-microservices-platform"
}

variable "cluster_name" {
  default = "smp-eks-cluster"
}

variable "domain_name" {
  description = "Your root domain, example: example.com"
  default     = "yourdomain.com"
}

variable "app_domain" {
  description = "Application domain"
  default     = "app.yourdomain.com"
}