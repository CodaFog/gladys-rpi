## gladys-rpi Dockerfile


This repository contains **Dockerfile** of a dockerized [Gladys](https://gladysproject.com/fr/) based on a Hypriot image


### Base Docker Image

* [hypriot/rpi-node:argon](https://hub.docker.com/r/hypriot/rpi-node/)

### Installation

1. Install [Docker](https://www.docker.com/) on your Raspberry pi.

2. Create the directory used to store the mysql database :
```
    mkdir -p /home/pi/mysql
```
3. Start a container for the Gladys database :
```
    docker run --name gladys-mysql -v /home/pi/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=supersecretpassword -e MYSQL_DATABASE=gladys -e TZ=Europe/Paris -d hypriot/rpi-mysql
```
4. Initialize the Database by starting Gladys in development mode. It will be run only once. Remove the gladys-node-init container after this :
```
    mkdir -p /home/pi/hooks
    docker run --name gladys-node-init -v /home/pi/hooks:/usr/local/lib/node_modules/gladys/api/hooks -e NODE_ENV=development -e MYSQL_HOST=mysql -e MYSQL_PASSWORD=supersecretpassword -e MYSQL_PORT=3306 --link gladys-mysql:mysql codafog/gladys-rpi node init.js
    docker rm gladys-node-init
``` 
5. Start a new Gladys container :
```
    docker run --name gladys-node --restart=always -p 8080:8080 -v /home/pi/hooks:/usr/local/lib/node_modules/gladys/api/hooks -e NODE_ENV=production -e MYSQL_HOST=mysql -e MYSQL_PASSWORD=supersecretpassword -e MYSQL_PORT=3306 --link gladys-mysql:mysql -d codafog/gladys-rpi
```
6. Connect to your Raspberry IP at port 8080 with a web browser and enjoy playing with Gladys.
