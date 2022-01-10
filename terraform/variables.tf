variable "db_user" {
  type        = string
  default     = ""
  description = <<EOS
  -------------------------------------
  (Optional)
  The DB user name to be used for the database.
  -------------------------------------
EOS
}


variable "db_pass" {
  type        = string
  default     = ""
  description = <<EOS
  -------------------------------------
  (Optional)
  The DB password to be used for the database.
  -------------------------------------
EOS
}

variable "api_image" {
  type        = string
  default     = "ankur512512/eqworks-api"
  description = <<EOS
  -------------------------------------
  (Optional)
  The api image to be used for the application.
  -------------------------------------
EOS
}

variable "db_image" {
  type        = string
  default     = "ankur512512/eqworks-db"
  description = <<EOS
  -------------------------------------
  (Optional)
  The DB image to be used for the database.
  -------------------------------------
EOS
}

variable "api_label" {
  type        = string
  default     = "api"
  description = <<EOS
  -------------------------------------
  (Optional)
  The api label to be used for the application pod
  -------------------------------------
EOS
}

variable "db_label" {
  type        = string
  default     = "db"
  description = <<EOS
  -------------------------------------
  (Optional)
  The DB label to be used for the database pod
  -------------------------------------
EOS
}


### Service Variables ###

## API service variables

variable "svc_api_name" {
  type        = string
  default     = "eqworks-api"
  description = <<EOS
  -------------------------------------
  (Optional)
  Name of api service
  -------------------------------------
EOS
}

variable "svc_api_type" {
  type        = string
  default     = "NodePort"
  description = <<EOS
  -------------------------------------
  (Optional)
  Type of api service
  -------------------------------------
EOS
}

variable "svc_api_selector" {
  type        = string
  default     = "api"
  description = <<EOS
  -------------------------------------
  (Optional)
  Selector of api service
  -------------------------------------
EOS
}

variable "svc_api_port" {
  type        = string
  default     = "5000"
  description = <<EOS
  -------------------------------------
  (Optional)
  Port to be used for api service
  -------------------------------------
EOS
}

variable "svc_api_target_port" {
  type        = string
  default     = "5000"
  description = <<EOS
  -------------------------------------
  (Optional)
  Target port to used for api service
  -------------------------------------
EOS
}

variable "svc_api_node_port" {
  type        = string
  default     = "30007"
  description = <<EOS
  -------------------------------------
  (Optional)
  NodePort to be used for api service
  -------------------------------------
EOS
}


## DB service variables

variable "svc_db_name" {
  type        = string
  default     = "eqworks-db"
  description = <<EOS
  -------------------------------------
  (Optional)
  Name of db service
  -------------------------------------
EOS
}

variable "svc_db_type" {
  type        = string
  default     = "ClusterIP"
  description = <<EOS
  -------------------------------------
  (Optional)
  Type of db service
  -------------------------------------
EOS
}

variable "svc_db_selector" {
  type        = string
  default     = "db"
  description = <<EOS
  -------------------------------------
  (Optional)
  Selector to be of db service
  -------------------------------------
EOS
}

variable "svc_db_port" {
  type        = string
  default     = "5432"
  description = <<EOS
  -------------------------------------
  (Optional)
  Port to be used for db service
  -------------------------------------
EOS
}

variable "svc_db_target_port" {
  type        = string
  default     = "5432"
  description = <<EOS
  -------------------------------------
  (Optional)
  Target port to used for db service
  -------------------------------------
EOS
}

