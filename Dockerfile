ARG LIBC=musl

FROM ghcr.io/void-linux/void-$LIBC:latest

RUN <<EOT sh
  set -ex
  echo y | env XBPS_ARCH=x86_64-musl xbps-install -S
  echo y | env XBPS_ARCH=x86_64-musl xbps-install -y -A bash findutils
  find /var/cache/xbps -type f -print0 | xargs -0 -r rm -v
EOT

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
RUN chmod +x /entrypoint.sh

CMD [ "/bin/bash", "-il" ]
