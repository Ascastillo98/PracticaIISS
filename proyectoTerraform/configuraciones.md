# Práctica Terraform: Configuraciones
## Fichero 1: Config.tf
En primer lugar, indicamos los proveedores:
```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}
provider "docker" {}

```

Luego creamos la red:
```
# Creación de la red
resource "docker_network" "RedDocker" {
  name = "RedDocker"
}
```

Creamos el primer contenedor, junto a la imagen que utilizará:
```
# Contenedor 1
resource "docker_image" "wordpress" {
  name         = "wordpress"
  keep_locally = false
}

resource "docker_container" "wordpress" {
  image = docker_image.wordpress.image_id
  name  = "contenedorWordpress"

  ports {
    internal = 80
    external = 80
  }

  networks_advanced {
    name = docker_network.RedDocker.name
  }
}
```

Antes de crear el contenedor de Mariadb, hay que crear el volumen que utilizará:
```
# Creación del volumen para mariadb

# Definir el recurso de volumen de Docker
resource "docker_volume" "volumen_Mariadb" {
  name = "volumen_mariadb"
}

```

Y, por último, el contenedor de mariadb:
```
# Contenedor 2
resource "docker_image" "mariadb" {
  name         = "mariadb"
  keep_locally = false
}

resource "docker_container" "mariadb" {
  image = docker_image.wordpress.image_id
  name  = "contenedorMariadb"
  networks_advanced {
    name = docker_network.RedDocker.name
  }
  volumes {
    volume_name    = docker_volume.volumen_Mariadb.name
    container_path = "/usr/share"
  }
}
```

## Fichero 2: Variables.tf
En este fichero indicamos las variables que utiliza wordpress para su funcionamiento. Corresponden al host y un usuario y contraseña de prueba para poder llevar a cabo la configuración inicial:

```
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
```

## Comandos
* `Terraform init´ para poder hacer uso de terraform
* `Terraform fmt´ para corregir automáticamente fallos de sintaxis
* `Terraform validate´ para validar que la sintaxis es correcta
* `Terraform apply´ para crear los recursos indicados en config.tf y levantar el servicio. Al hacer esto, se crea o modifica el fichero Terraform.tfstate
* `Terraform destroy´ para destruir los recursos y cerrar el servicio
  
Se ha utilizado el editor nano para crear y modificar el contenido de los ficheros.  
