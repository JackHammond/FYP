
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
ADD r-d-service-0.0.1-SNAPSHOT.jar r-d-service.jar
EXPOSE 8761
ENTRYPOINT exec java $JAVA_OPTS -jar r-d-service.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar r-d-service.jar
