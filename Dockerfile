# Use OpenJDK 17 based on Debian Buster as the base image
FROM openjdk:17-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Install necessary tools, including xargs
RUN apt-get update && apt-get install -y \
    findutils \
    && rm -rf /var/lib/apt/lists/*

# Copy the local code to the container
COPY . .

# Set the appropriate file permissions for Gradle
RUN chmod +x ./gradlew

# Build the application
RUN ./gradlew clean fatJar

# Set the time zone
ENV TZ=Europe/Kiev

# Specify the command to run the application
CMD ["java", "-jar", "build/libs/ThEconomistDownloader-1.0-SNAPSHOT.jar"]
