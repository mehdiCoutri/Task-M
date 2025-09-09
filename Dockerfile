FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY target/task-manager-1.0-SNAPSHOT.jar 
ENTRYPOINT ["java","-jar","/app.jar"]
