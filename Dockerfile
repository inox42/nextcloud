FROM nextcloud:21.0.1
MAINTAINER inox42

# Define default ID
ENV UID=1000 GID=1000

# Copy script to update user & group
COPY rootfs/run.sh /
RUN chmod 555 /run.sh

# Edit entrypoint
RUN cp /entrypoint.sh /entrypoint.sh.old 
RUN sed '118i\/run.sh' /entrypoint.sh.old > /entrypoint.sh
RUN sed -i 's/www-data/nextcloud/g' /entrypoint.sh
RUN chmod 555 /entrypoint.sh

# Change apache2 user
RUN sed -i 's/www-data/nextcloud/g' /etc/apache2/envvars

# Default Nextcloud config
VOLUME /var/www/html
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]