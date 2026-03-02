# Base Tomcat image with JDK 17
FROM tomcat:9-jdk17-temurin

# Remove default apps (optional but recommended)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR built by Maven pipeline
COPY target/game.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
