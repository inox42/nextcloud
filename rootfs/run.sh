#!/bin/sh

echo "Updating permissions..."
for dir in /var/www/html /var/log /et/apache2 /tmp ; do
  if $(find $dir ! -user $UID -o ! -group $GID|egrep '.' -q); then
    echo "Updating permissions in $dir..."
    chown -R $UID:$GID $dir
  else
    echo "Permissions in $dir are correct."
  fi
done
echo "Done updating permissions."

echo "Check for UserId ${UID}"
grep ":${UID}:" /etc/passwd 1>/dev/null 2>&1
ERRORCODE=$?

if [ $ERRORCODE -ne 0 ]; then
   echo "Creating user nextcloud with UID=${UID} and GID=${GID}"
   /usr/sbin/adduser -g ${GID} -u ${UID} --disabled-password  --gecos "" nextcloud
else
   echo "An existing user with UID=${UID} was found, nothing to do"
fi

echo "Run Nextcloud"
/entrypoint.sh

exit 0
