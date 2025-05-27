# Maven build container 

FROM maven:3.5.2-jdk-8-alpine AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package -DskipTests

#pull base image

FROM eclipse-temurin:17-jdk-alpine


#expose port 8080
EXPOSE 8080


#copy hello world to docker image from builder image

COPY --from=maven_build /build/target/*.jar /app/app.jar

#default command
CMD ["java", "-jar", "/data/hello-world-0.1.0.jar"]

