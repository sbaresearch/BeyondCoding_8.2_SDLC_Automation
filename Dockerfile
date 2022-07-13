FROM maven:3.8.4-jdk-11-slim

RUN useradd -m -d /home/user -s /bin/bash user
USER user

COPY --chown=user:user pom.xml /home/user/src/app/
COPY --chown=user:user src /home/user/src/app/src

RUN mvn -f /home/user/src/app/pom.xml -B package assembly:single

ENTRYPOINT ["java", "-jar", "/home/user/src/app/target/automation-demo-1.0-SNAPSHOT-jar-with-dependencies.jar"]
