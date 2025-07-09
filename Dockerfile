# ---- Stage 1: Build the application ----
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# TEMP: Debug file structure
RUN find /app

# ---- Stage 2: Package the app ----
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Update this path based on what you see in `find` output
COPY --from=build /app/<correct-module>/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
