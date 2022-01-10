provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_pod" "createpod" {
  for_each = local.pod_config
  metadata {
    name = each.key
    labels = {
      app = each.value.label
    }
  }
  spec {
    container {
      image = each.value.image
      name  = each.key
      dynamic "env" {
        for_each = each.value.envars
        content {
          name  = env.value.name
          value = env.value.value
        }
      }
    }
  }
}

resource "kubernetes_service" "service_api" {
  metadata {
    name = var.svc_api_name
  }
  spec {
    type = var.svc_api_type
    selector = {
      app = var.svc_api_selector
    }
    port {
      port        = var.svc_api_port
      target_port = var.svc_api_target_port
      node_port   = var.svc_api_node_port
    }
  }
}

resource "kubernetes_service" "service_db" {
  metadata {
    name = var.svc_db_name
  }
  spec {
    type = var.svc_db_type
    selector = {
      app = var.svc_db_selector
    }
    port {
      port        = var.svc_db_port
      target_port = var.svc_db_target_port
    }
  }
}
