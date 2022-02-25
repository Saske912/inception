#!/bin/bash

if ! hostnamectl | grep 'Operating System: Linux Mint [2-9][0-9]' > /dev/null
then
  read -p "Operating System may be not supported. Continue?(y/n): " continue
  if [ continue == 'y' ]
    then
      return
    else
      echo "Good Bye"
      exit
  fi
fi

function checkPackage {
  if ! echo $(dpkg-query -W -f='${Status}' $1) | grep "ok installed" > /dev/null
  then
    read -p "${1} require. Install?(y/n): " install
    if [ $install == 'y' ]
    then
      sudo apt-get install -y $1
    else
      echo "Good Bye"
      exit
    fi
  fi
}

checkPackage "virtualbox";
checkPackage "vagrant";
checkPackage "ansible";

export $(cat ./srcs/.env | xargs)

if ! vagrant plugin list | grep "vagrant-hostsupdater" > /dev/null
then
  vagrant plugin install vagrant-hostsupdater
fi

cd srcs && vagrant up "${NAME}"