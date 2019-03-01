# docker-drupal-php-apache

Built for Drupal 8 development. Currently needs to be built locally:

```
docker build --tag drupal-php-apache .
```

docker-compose.yml:

```
version: '3'
services:
  app:
    image: drupal-php-apache:latest
    volumes:
      - ./src:/var/www/html
    ports:
      - 80:80
  db:
    image: mysql:5.7
    volumes:
      - dbdata:/var/lib/mysql
    ports:
      - 3306:3306
    environment:
      - MYSQL_USER=drupal
      - MYSQL_DATABASE=drupal
      - MYSQL_PASSWORD=drupal
      - MYSQL_ROOT_PASSWORD=secret

volumes:
  dbdata:
```