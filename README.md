# EspoCRM dockerised
Dockerised version of espocrm

## Installation for production

- Clone this repository: `git clone git://github.com/theBuzzyCoder/dockerised-espo.git $HOME/dockerised-espo`
- Build and run for the first time: `docker-compose -f $HOME/dockerised-espo/docker-compose.yml -p $HOME/dockerised-espo up -d --build`
- Second time onwards: `docker-compose -f $HOME/dockerised-espo/docker-compose.yml -p $HOME/dockerised-espo up -d`

## Installation for Development

**NOTE: Do not clone this repository. Follow Below Setups and it will automatically clone the repository**

*In that Order*

Below command will make the complete setup of docker version of espocrm in your machine.

`curl --silent --show-error https://raw.githubusercontent.com/theBuzzyCoder/dockerised-espo/master/installer.sh | sh`

Finally run

#### During first docker compose up. This will build the image

`docker-compose -f dockerised-espo/development.docker-compose.yml -p dockerised-espo up -d --build`

#### From second time onwards!
`docker-compose up -d`

## See Nginx or PHP-FPM Logs

Note: containerId is just a place holder
`docker container logs <containerId>`
