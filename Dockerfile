FROM ubuntu
RUN apt update -y && apt install python3 -y
ENV DEBIAN_FRONTEND=noninteractive

CMD ls
