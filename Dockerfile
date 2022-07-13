FROM maven:3.8-jdk-11-slim as builder

RUN useradd -m -d /home/user -s /bin/bash user
USER user

COPY --chown=user:user pom.xml /home/user/src/app/
COPY --chown=user:user src /home/user/src/app/src

RUN mvn -f /home/user/src/app/pom.xml -B package assembly:single

FROM openjdk:11-jre-slim as runner

COPY --from=builder /home/user/src/app/target/automation-demo-1.0-SNAPSHOT-jar-with-dependencies.jar /usr/local/

RUN useradd -m -d /home/user -s /bin/bash user
USER user

ENTRYPOINT ["java", "-jar", "/usr/local/automation-demo-1.0-SNAPSHOT-jar-with-dependencies.jar"]
