# Práctica Docker: Configuraciones

## Ejercicio 1

* Creamos la carpeta drupal81 `mkdir drupal81´
* Creamos el archivo dockerfile usando nano `nano dockerfile´
* Contenido del archivo:
  
```FROM drupal
RUN sed -i 's/Listen 80/Listen 81/g' /etc/apache2/ports.conf
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
EXPOSE 81
ENTRYPOINT apache2ctl -D FOREGROUND
´´´

* El comando sed es el más importante, para cambiar el puerto por defecto de drupal
* Creamos la carpeta dockercompose1 `mkdir dockercompose1´
* Creamos el primer docker-compose. Este fichero está subido en el repositorio. Podemos indicar los volúmenes en el yml mediante `volumes: vol-drupal´ y ´volumes: vol-mysql´
* Levantamos el servicio con `docker-compose up´ y accedemos a localhost81 para ver los resultados

## Ejercicio 2

* Creamos la carpeta wordpress82 `mkdir wordpress82´
* Creamos el archivo dockerfile para cambiar el puerto por defecto `nano dockerfile
* Contenido del archivo:
```FROM wordpress
RUN sed -i 's/Listen 80/Listen 82/g' /etc/apache2/ports.conf
EXPOSE 82
´´´

* El único cambio que debemos realizar es el comando sed para cambiar el puerto por defecto al puerto 82
* Creamos la carpeta dockercompose2 `mkdir wordpress82´
* Creamos el segundo docker-compose.yml `nano docker-compose.yml´. Este archivo está subido al repositorio. Se añaden los servicios con variables de entorno que permitan crear un usuario ficticio, y se añade la red a la que los dockers se conectan con la `networks: redDocker´. Se indica que el servicio wordpress depende de mariadb para su funcionamiento. 
* Levantamos el servicio con `docker-compose up´ y accedemos a localhost82 para ver los resultados




















