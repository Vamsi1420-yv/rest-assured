# Step 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Build only the 'rest-assured' module and its dependencies, skip tests
RUN mvn clean package -pl rest-assured -am -DskipTests

# Step 2: Create a minimal runtime image
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy the JAR built in the previous stage
COPY --from=build /app/rest-assured/target/*.jar app.jar

# Set the default command
CMD ["java", "-jar", "app.jar"]
