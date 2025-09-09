# المرحلة 1: البناء
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# المرحلة 2: التشغيل
FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY --from=build /app/target/task-manager-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
