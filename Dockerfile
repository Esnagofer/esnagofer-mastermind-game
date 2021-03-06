#STEP 1 - Build project

FROM maven:3.3-jdk-8 as builder

# Create app directory
WORKDIR /app
COPY pom.xml .
RUN mvn org.apache.maven.plugins:maven-dependency-plugin:3.0.2:go-offline

# Build JAR
COPY . .
RUN mvn verify


# STEP 2 - Copy binary to container

FROM openjdk:8-jre-slim

COPY --from=builder /app/target/esnagofer-mastermind-game-*.jar /opt/esnagofer-mastermind-game.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/opt/esnagofer-mastermind-game.jar"]