# IoT Docker Setup with Node-Red, Mosquitto and OpenHab

This Setup is using the official Docker Images of
* Node-Red ([DockerHub](https://hub.docker.com/r/nodered/node-red/))
* Mosquitto ([DockerHub](https://hub.docker.com/_/eclipse-mosquitto/))
* OpenHab ([DockerHub](https://hub.docker.com/r/openhab/openhab/))


## Usage

Use the `.env` file to place the Mosquitto credentials and your User/Group Id for OpenHab

```
MOSQUITTO_USERNAME=mosquitto
MOSQUITTO_PASSWORD=mosquitto

OPENHAB_USER_ID=1000
OPENHAB_GROUP_ID=1000
```


### Build and run

```
docker-compose build
docker-compose up -d
```