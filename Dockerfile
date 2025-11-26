# Multi-stage Dockerfile for Kotlin Spring Boot Application

# Stage 1: Build stage
FROM gradle:8.5-jdk17 AS build

WORKDIR /app

# Copy gradle files
COPY build.gradle.kts settings.gradle.kts ./

# Download dependencies
RUN gradle dependencies --no-daemon || true

# Copy source code
COPY src ./src

# Build the application
RUN gradle bootJar --no-daemon

# Stage 2: Runtime stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Create a non-root user and data directory
RUN addgroup -S spring && adduser -S spring -G spring && \
    mkdir -p /app/data && \
    chown -R spring:spring /app

# Copy the jar from build stage
COPY --from=build --chown=spring:spring /app/build/libs/*.jar app.jar

# Switch to non-root user
USER spring:spring

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=20s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
