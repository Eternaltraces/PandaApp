FROM rtfpessoa/ubuntu-jdk8
WORKDIR /home
COPY agent.jar .
RUN apt-get update -y 
RUN adduser --disabled-password --gecos "" jenkins
RUN apt-get install git -y
RUN apt-get install maven -y
RUN curl -fsSL https://get.docker.com/ | sh