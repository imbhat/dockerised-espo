if [ ! -f $(which apt) ]; then
  echo "Expecting apt. Please do the work around because apt is not available in non-debian OS.";
  echo "Use brew for mac";
  echo "Use apk for alpine";
  echo "Use yum for Fedora";
  exit
fi

if [ ! -f "$(which docker)" ]; then
  echo "docker not found. Install docker first ..."
  exit
fi

if [ ! -f "$(which docker-compose)" ]; then
  echo "docker-compose not found. Installing it now ..."
  sudo apt install docker-compose
fi

sudo apt install git

export WORKDIR=$HOME/dockerised-espo
mkdir -p $WORKDIR

if [ -d $WORKDIR/php7.2-espocrm ]; then
  echo "php directory found";
else
  git clone git://github.com/theBuzzyCoder/dockerised-espo.git $WORKDIR
fi

cd $WORKDIR/php7.2-espocrm

git clone git://github.com/espocrm/espocrm.git
export CRMDIR=$WORKDIR/php7.2-espocrm/espocrm
cd $CRMDIR

if [ -f "$(which composer)" ]; then
  composer install -o
else
  curl --silent --show-error https://getcomposer.org/installer | php && cp composer.phar /usr/local/bin/composer
  composer install -o
fi

# Add developer mode to espocrm/data/config.php
echo "<?php return ['isDeveloperMode' => true]; ?>" > $CRMDIR/data/config.php

sudo apt install nodejs npm
sudo npm install -g grunt

# Building node_modules in local machine before mount for development enviornment
sudo npm install

# Compiling less to generate compiled css
grunt less

cd $WORKDIR
docker build -t php-espocrm:stable php7.2-espocrm
