# Step 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

# Build everything (assumes multi-module), skip tests
RUN mvn clean package -DskipTests

# Step 2: Minimal runtime image
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy actual JAR from correct submodule (adjust path below if needed)
COPY --from=build /app/rest-assured/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
