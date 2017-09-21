FROM openjdk:8-jre
LABEL maintainer Tom Taylor <tom@dockerfiles@tomm.yt>

EXPOSE 2181 9092
ARG KAFKA_VERSION=0.10.2.1
ARG SCALA_VERSION=2.11

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /dumb-init
RUN chmod 755 /dumb-init && \
    cd /opt && \
    curl -sL http://www.mirrorservice.org/sites/ftp.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz | tar zx
ENV KAFKA_HOME=/opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ADD start-all.sh /

WORKDIR ${KAFKA_HOME}
ENTRYPOINT [ "/dumb-init", "/start-all.sh" ]
