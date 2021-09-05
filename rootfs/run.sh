#!/bin/bash

echo "Check www-data UserId ${UID}"
if [ $(id -u www-data) -ne ${UID} ];then
  echo "Change www-data UID to ${UID}";
  usermod -u ${UID} -o www-data;
else
  echo "www-data UID is up-to-date";
fi

echo "Check www-data GroupId ${GID}"
if [ $(id -g www-data) -ne ${GID} ]; then
   echo "Change www-data GID to ${GID}"
   groupmod -g ${GID} -o www-data
else
   echo "www-data GID is up-to-date"
fi

echo "Updating permissions..."
chown -R www-data:www-data /var/www/*

exit 0