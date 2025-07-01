FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .

# 👇 Adjust this path if your module is inside 'modules/' or similar
RUN mvn clean package -pl modules/rest-assured -am -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app

# 👇 Adjust target path accordingly
COPY --from=build /app/modules/rest-assured/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
