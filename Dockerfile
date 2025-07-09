# ---- Stage 1: Build the application ----
FROM maven:3.9.6-eclipse-temurin-17 as build

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the project (adjust module name if needed)
RUN mvn clean package -DskipTests

# ---- Stage 2: Run the application ----
FROM eclipse-temurin:17-jdk

# Set working directory in the runtime image
WORKDIR /app

# Copy the built JAR from the build stage
# Replace with correct module path (e.g., rest-assured-examples)
COPY --from=build /app/rest-assured-examples/target/*.jar app.jar

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
