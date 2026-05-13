resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "microservices-ingress"
    namespace = kubernetes_namespace.app.metadata[0].name

    annotations = {
      "kubernetes.io/ingress.class"                  = "alb"
      "alb.ingress.kubernetes.io/scheme"             = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"        = "ip"
      "alb.ingress.kubernetes.io/listen-ports"       = "[{\"HTTP\":80},{\"HTTPS\":443}]"
      "alb.ingress.kubernetes.io/certificate-arn"    = aws_acm_certificate_validation.app_cert.certificate_arn
      "alb.ingress.kubernetes.io/ssl-redirect"       = "443"
      "alb.ingress.kubernetes.io/healthcheck-path"   = "/"
      "alb.ingress.kubernetes.io/group.name"         = "${var.project_name}-alb"
    }
  }

  spec {
    rule {
      host = var.app_domain

      http {
        path {
          path      = "/api"
          path_type = "Prefix"

          backend {
            service {
              name = "user-service"
              port {
                number = 8080
              }
            }
          }
        }

        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "client-service"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.aws_lb_controller,
    aws_acm_certificate_validation.app_cert
  ]
}