# dockerised-espo
Dockerised version of espocrm


# Installation for Development

**NOTE: Do not clone this repository. Follow Below Setups and it will automatically clone the repository**

*In that Order*

Below command will make the complete setup of docker version of espocrm in your machine.

`curl --silent --show-error https://raw.githubusercontent.com/theBuzzyCoder/dockerised-espo/master/installer.sh | sh`

Finally run

#### During first docker compose up. This will build the image

`docker-compose -f docker-compose.development.yml -p dockerised-espo up -d --build`

#### From second time onwards!
`docker-compose up -d`

### To check the logs

Note: containerId is just a place holder
`docker container logs <containerId>`
