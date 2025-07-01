# Step 1: Build the application using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .

# 👇 Build only the 'rest-assured' module
RUN mvn clean package -pl rest-assured -am -DskipTests

# Step 2: Create a minimal runtime image
FROM eclipse-temurin:17-jre
WORKDIR /app

# 👇 Copy the built JAR from the module
COPY --from=build /app/rest-assured/target/*.jar app.jar

# Run the app
CMD ["java", "-jar", "app.jar"]
