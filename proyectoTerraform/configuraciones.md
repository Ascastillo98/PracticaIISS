#Práctica Terraform: Configuraciones
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
