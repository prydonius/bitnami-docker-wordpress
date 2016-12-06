FROM gcr.io/stacksmith-images/ubuntu:14.04-r10

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=wordpress \
    BITNAMI_IMAGE_VERSION=4.6.1-r3 \
    PATH=/opt/bitnami/php/bin:/opt/bitnami/mysql/bin/:$PATH

# Additional modules required
RUN bitnami-pkg unpack apache-2.4.23-10 --checksum 29195ce6cd437c2880fb7c627880932c7c13df6032fc7b25c1ae3bccd27b20e2
RUN bitnami-pkg unpack php-5.6.28-0 --checksum 703ee1e4aa2fb1d3739633972aadae0e6620bd6c4d8520cea08f5ba9bfa589f2
RUN bitnami-pkg install libphp-5.6.28-0 --checksum db18a785d7941f65316656f3f19b939b311b921e3c2c9653c2e473885b8916ed
RUN bitnami-pkg install mysql-client-10.1.19-0 --checksum fdbc292bedabeaf0148d66770b8aa0ab88012ce67b459d6ba2b46446c91bb79c

# Install wordpress
RUN bitnami-pkg unpack wordpress-4.6.1-3 --checksum 48ff2e4147fb27458c202eb4bc14afd36a76e0fbb0f5721e8b5900a59cf37b58

COPY rootfs /

VOLUME ["/bitnami/wordpress", "/bitnami/apache", "/bitnami/php"]

EXPOSE 80 443

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["nami", "start", "--foreground", "apache"]
