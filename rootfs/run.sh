#!/bin/sh

echo "Check for GroupId ${GID}"
grep "nextcloud" /etc/group 1>/dev/null 2>&1
ERRORCODE=$?
if [ $ERRORCODE -ne 0 ]; then
   echo "Creating group nextcloud with GID=${GID}"
   groupadd -g ${GID} -o nextcloud
else
   echo "Update group nextcloud with GID=${GID}"
   groupmod -g ${GID} -o nextcloud
fi

echo "Check for UserId ${UID}"
grep "nextcloud" /etc/passwd 1>/dev/null 2>&1
ERRORCODE=$?
if [ $ERRORCODE -ne 0 ]; then
   echo "Creating user nextcloud with UID=${UID} and GID=${GID}"
   useradd -g ${GID} -u ${UID} -o nextcloud
else
   echo "Update user nextcloud with UID=${UID}"
   usermod -u ${UID} -o nextcloud
fi

echo "Updating permissions..."
chown -R nextcloud:nextcloud /var/www/*

exit 0