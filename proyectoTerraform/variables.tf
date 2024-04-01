variable "wordpress_db_host" {
  description = "Dirección del host de la base de datos de WordPress"
  type        = string
  default     = "Host"
}

variable "wordpress_db_name" {
  description = "Nombre de la base de datos de WordPress"
  type        = string
  default     = "database"
}

variable "wordpress_db_user" {
  description = "Usuario de la base de datos de WordPress"
  type        = string
  default     = "user"
}

variable "wordpress_db_password" {
  description = "Contraseña de la base de datos de WordPress"
  type        = string
  default     = "pwd"
}
