# Maven build container
FROM maven:3.5.2-jdk-8-alpine AS maven_build

WORKDIR /build

COPY pom.xml .
COPY src ./src

RUN mvn -B package

# Runtime image
FROM eclipse-temurin:8-jdk-alpine

WORKDIR /app

# Copy the built jar from the first stage
COPY --from=maven_build /build/target/*.jar /app/app.jar

# Expose application port
EXPOSE 8080

# Run the app
CMD ["java", "-jar", "/app/app.jar"]
