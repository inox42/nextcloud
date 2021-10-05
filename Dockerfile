FROM nextcloud:22.2.0

# Define default ID
ENV UID=33 GID=33

#Install php-imagemagick
RUN apt-get update
RUN apt-get install -y imagemagick
RUN apt-get clean

# Copy script to update user & group
COPY rootfs/run.sh /
RUN chmod 555 /run.sh

# Edit entrypoint
RUN cp /entrypoint.sh /entrypoint.sh.old 
RUN sed '45i\/bin/bash /run.sh' /entrypoint.sh.old > /entrypoint.sh
RUN chmod 555 /entrypoint.sh

# Default Nextcloud config
VOLUME /var/www/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
