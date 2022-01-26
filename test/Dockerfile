FROM ubuntu:20.04
RUN apt update
RUN apt install -y git
RUN apt install -y sudo

RUN adduser --disabled-password --gecos '' kumori
RUN adduser kumori sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER kumori
WORKDIR /home/kumori
