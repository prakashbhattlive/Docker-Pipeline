FROM maven:3-alpine

COPY pom.xml pipeline/

WORKDIR pipeline/

RUN mvn clean install

EXPOSE 8090

ENTRYPOINT ["java","-jar","/pipeline/target/jenkins-pipeline.jar"]
