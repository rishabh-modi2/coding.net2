FROM ubuntu
RUN apt update -y && apt upgrade -y
ENV DEBIAN_FRONTEND=noninteractive

CMD ls
