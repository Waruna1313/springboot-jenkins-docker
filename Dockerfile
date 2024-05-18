FROM eclipse-temurin:17-jdk-alpine AS builder

# Set working directory for the builder stage
WORKDIR /app

# Copy the project source code
COPY . .

# Use Maven to build the application (adjust based on your build tool)
RUN mvn clean package

# Create a slimmer image for runtime
FROM eclipse-temurin:17-jre-alpine

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Set the working directory for the runtime stage
WORKDIR /app

# Expose the Spring Boot application port (modify if needed)
EXPOSE 8081

# Command to run the application
CMD ["java", "-jar", "app.jar"]
