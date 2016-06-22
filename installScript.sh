# this is installing the entire mongodb package, rather than just the server
UBUNTUREPO="http://repo.mongodb.org/apt/ubuntu \"$(lsb_release -sc)\"/mongodb-org/stable multiverse"
UBUNTUKEYSERV="hkp://keyserver.ubuntu.com:80"
UBUNTUKEYRECV="EA312927"
RHELREPO="https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/stable/\$basearch/"
RHELKEYSERV="https://www.mongodb.org/static/pgp/server-3.2.asc"

PACKAGES="mongodb-org"

# grep Ubuntu /etc/issue

if which apt-get 
then
  # commands to install on Ubuntu
  # adding the key
  apt-key adv --keyserver $UBUNTUKEYSERV --recv $UBUNTUKEYRECV
  #echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/stable multiverse" | tee /etc/apt/sources.list.d/mongodb-org.list
  echo "deb $UBUNTUREPO" | tee /etc/apt/sources.list.d/mongodb.list
  apt-get update
  apt-get -y install $PACKAGES

elif which yum
then
  echo "[mongodb]
name=MongoDB Repository
baseurl=$RHELREPO
gpgcheck=1
enabled=1
gpgkey=$RHELKEYSERV" > /etc/yum.repos.d/mongodb.repo

  yum -y install $PACKAGES

else
  echo "OS is not supported by the install script" 
  exit 1

fi

exit