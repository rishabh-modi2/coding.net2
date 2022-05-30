FROM ubuntu
RUN apt update -y && apt install tmate -y
ENV DEBIAN_FRONTEND=noninteractive

CMD ls
