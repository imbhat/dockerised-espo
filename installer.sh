echo "This installer is for only development mode on local machine"


if [ ! -f $(which apt-get) ]; then
  echo "Expecting apt-get. Please do the work around because apt-get is not available in non-debian OS.";
  echo "Use brew for mac";
  echo "Use apk for alpine";
  echo "Use yum for Fedora";
  exit
fi

if [ ! -f "$(which docker)" ]; then
  echo "docker not found. Install docker first ... \nSee https://docs.docker.com/install/"
  exit
fi

if [ ! -f "$(which docker-compose)" ]; then
  echo "docker-compose not found. Installing it now ..."
  sudo apt-get install -y docker-compose
fi

sudo apt-get install -y git

set -x
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

docker run --rm -v $(pwd):/app composer/composer:latest install --ignore-platform-reqs
docker run -it --rm -v $(pwd):/srv -w="/srv/src/resource" huli/grunt:alpine less

# Add developer mode to espocrm/data/config.php
echo "<?php return ['isDeveloperMode' => true]; ?>" > $CRMDIR/data/config.php
