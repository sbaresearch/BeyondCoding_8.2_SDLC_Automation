FROM maven:3.8.4-jdk-11-slim

COPY src /usr/src/app/src
ADD pom.xml /usr/src/app

RUN mvn -f /usr/src/app/pom.xml clean package assembly:single -Dmaven.test.skip=true

ENTRYPOINT ["java", "-jar", "/usr/src/app/target/automation-demo-1.0-SNAPSHOT-jar-with-dependencies.jar"]
