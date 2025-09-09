FROM openjdk:8-jdk-alpine
VOLUME /tmp

# انسخ الـ jar إلى داخل الحاوية باسم app.jar
COPY target/task-manager-1.0-SNAPSHOT.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
