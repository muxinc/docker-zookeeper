FROM openjdk:8u111-jre-alpine
MAINTAINER Scott Kidder <scott@mux.com>

ARG MIRROR=http://apache.mirrors.pair.com
ARG VERSION=3.4.9

LABEL name="zookeeper" version=$VERSION

RUN apk add --no-cache wget bash \
    && mkdir /opt \
    && wget -q -O - $MIRROR/zookeeper/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-$VERSION /opt/zookeeper \
    && mkdir -p /tmp/zookeeper

ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"]
