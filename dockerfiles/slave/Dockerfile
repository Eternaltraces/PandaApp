FROM rtfpessoa/ubuntu-jdk8
WORKDIR /home
COPY dockerfiles/slave/agent.jar .
RUN apt-get update -y && apt-get install -y git maven
RUN adduser --disabled-password --gecos "" jenkins
RUN curl -fsSL https://get.docker.com/ | sh
