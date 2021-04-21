FROM nextcloud:21.0.1
MAINTAINER inox42

ENV UID=1000 GID=1000

COPY rootfs/*.sh /

ENTRYPOINT ["/run.sh"]