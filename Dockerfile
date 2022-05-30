FROM tmate
//RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
//RUN apt update -y && apt install python3 -y
ENV DEBIAN_FRONTEND=noninteractive
