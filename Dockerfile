# Stage 1: Build the library with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .

# Run Maven package (without tests for faster build)
RUN mvn clean package -DskipTests

# TEMP: List built artifacts (for debug)
RUN find /app -name "*.jar"

# Stage 2: (Optional) Copy artifacts to a smaller image
# Only useful if you want to extract the built .jar files

FROM alpine:latest
WORKDIR /output

# Copy all built JARs from build stage
COPY --from=build /app /output

# Just show what was copi
