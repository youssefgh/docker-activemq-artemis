FROM docker.pkg.github.com/youssefgh/docker-openjdk/openjdk:11.0.4_p4-r1

LABEL maintainer="Youssef GHOUBACH <ghoubach.youssef@gmail.com>"

RUN apk add --update \
    curl

ENV VERSION 2.11.0

ENV PACKAGE_NAME apache-artemis-$VERSION-bin

ENV PACKAGE_TAR $PACKAGE_NAME.tar.gz

ENV PACKAGE https://www-eu.apache.org/dist/activemq/activemq-artemis/$VERSION/$PACKAGE_TAR

RUN cd /opt \
    && curl -L -O $PACKAGE \
    && tar -xvzf $PACKAGE_TAR \
    && rm $PACKAGE_TAR

ENV ARTEMIS_HOME=/opt/apache-artemis-$VERSION

ENV ARTEMIS_BROKER_HOME=/var/lib/default-broker

RUN $ARTEMIS_HOME/bin/artemis create $ARTEMIS_BROKER_HOME --user artemis --password artemis --allow-anonymous --http-host 0.0.0.0

EXPOSE 61616 8161

WORKDIR $ARTEMIS_BROKER_HOME

ENTRYPOINT $ARTEMIS_BROKER_HOME/bin/artemis run
