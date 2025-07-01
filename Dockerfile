# Step 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy everything
COPY . .

# Build the full project and skip tests
RUN mvn clean package -DskipTests

# Step 2: Create a minimal runtime image
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
