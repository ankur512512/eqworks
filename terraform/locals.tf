

locals {
  pod_config = {
    "api" = { image = "${var.api_image}", label = "${var.api_label}", envars = [{
      name  = "SQL_URI"
      value = "postgresql://${var.db_user}:${var.db_pass}@${var.svc_db_name}/work_samples"
    }] },
    "db" = { image = "${var.db_image}", label = "${var.db_label}", envars = [{
      name  = "POSTGRES_USER"
      value = "${var.db_user}"
      },
      {
        name  = "POSTGRES_PASSWORD"
        value = "${var.db_pass}"
    }] }
  }
}
