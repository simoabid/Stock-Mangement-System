# Stage 1: Build the application using Maven
FROM maven:3.9.4-eclipse-temurin-11 AS build
WORKDIR /app
# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src
# Build the WAR file
RUN mvn clean package -DskipTests

# Stage 2: Run the application on Tomcat
FROM tomcat:10.1-jdk11
# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy our WAR
COPY --from=build /app/target/pharmacy.war /usr/local/tomcat/webapps/pharmacy.war
# Create setenv.sh that reads from environment variables (set by docker-compose)
RUN echo 'export CATALINA_OPTS="-Djdbc.url=\"${JDBC_URL}\" -Djdbc.user=${JDBC_USER} -Djdbc.password=${JDBC_PASSWORD} -Djdbc.driver=${JDBC_DRIVER}"' > /usr/local/tomcat/bin/setenv.sh
