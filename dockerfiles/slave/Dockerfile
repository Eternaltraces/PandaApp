FROM picoded/ubuntu-openjdk-8-jdk
WORKDIR /home
COPY agent.jar .
RUN apt-get update -y && apt-get install -y git maven
RUN adduser --disabled-password --gecos "" jenkins
RUN curl -fsSL https://get.docker.com/ | sh
