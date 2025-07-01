# Stage 1: Build with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy entire project
COPY . .

# Build the project and skip tests if needed
RUN mvn clean install -DskipTests

# Stage 2: Runtime (optional, if creating a runnable jar or fat jar)
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy built artifacts from the build stage
COPY --from=build /app/target/*.jar app.jar

# Default command to run the application (adjust jar name if needed)
CMD ["java", "-jar", "app.jar"]
