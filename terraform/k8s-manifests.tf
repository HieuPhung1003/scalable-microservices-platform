resource "kubernetes_namespace" "app" {
  metadata {
    name = local.app_namespace
  }

  depends_on = [module.eks]
}

resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  data = {
    APP_ENV    = "dev"
    REDIS_HOST = aws_elasticache_cluster.redis.cache_nodes[0].address
    REDIS_PORT = "6379"
    DB_HOST    = aws_db_instance.postgres.address
    DB_PORT    = "5432"
    KAFKA_BOOTSTRAP_SERVERS = aws_msk_cluster.kafka.bootstrap_brokers
  }
}

resource "kubernetes_secret" "app_secret" {
  metadata {
    name      = "app-secret"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  data = {
    DB_USER     = "postgres"
    DB_PASSWORD = "ChangeMe123!"
  }

  type = "Opaque"
}