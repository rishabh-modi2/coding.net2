FROM ubuntu
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
RUN apt-get -y update \
    && apt-get -y install tmate curl sudo wget git nodejs nano unzip zip unrar npm pip wget curl tar python3 ffmpeg python3-pip \
    && ssh -t host tmate
RUN rm -rf rclone
RUN git clone https://github.com/rishabh-modi2/rclone
WORKDIR /rclone
RUN npm install
RUN mkdir -p /app
ADD start.sh /app/
RUN mkdir -p /root/.ngrok2
ADD ngrok.yml /root/.ngrok2/
CMD bash /app/start.sh
