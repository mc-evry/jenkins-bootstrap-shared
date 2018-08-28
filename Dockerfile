#https://github.com/anapsix/docker-alpine-java
FROM anapsix/alpine-java:8_jdk

ADD build/distributions/*.tar /usr/

RUN addgroup -g 993 -S docker  && \
    adduser -u 1001 -h /var/lib/jenkins -S jenkins -G docker

RUN apk add --no-cache git rsync openssh openrc nano iputils maven docker && \
mkdir -p /var/cache/jenkins && \
chown -R jenkins: /usr/lib/jenkins /usr/distribution-scripts /var/cache/jenkins && \
cp /usr/distribution-scripts/docker/run.sh /run.sh

EXPOSE 8080/tcp

USER jenkins
WORKDIR /var/lib/jenkins
ENV JAVA_HOME="/opt/jdk"
CMD /run.sh