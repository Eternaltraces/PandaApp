FROM openjdk:11.0
WORKDIR /
COPY target/panda*.jar /application.jar
EXPOSE 8080
CMD java -jar application.jar
