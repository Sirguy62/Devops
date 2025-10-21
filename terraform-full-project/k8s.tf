resource "kubernetes_namespace" "demo" {
  metadata { name = "demo" }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name      = "nginx-deployment"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = { app = "nginx" }
    }
    template {
      metadata { labels = { app = "nginx" } }
      spec {
        container {
          name  = "nginx"
          image = "nginx:latest"
          port { container_port = 80 }
        }
      }
    }
  }
}
