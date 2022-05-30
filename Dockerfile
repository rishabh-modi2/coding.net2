FROM ubuntu
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -y update && apt -y upgrade
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update \
    && apt-get -y install tmate curl wget git nodejs nano unzip zip unrar npm pip wget curl tar python3 ffmpeg python3-pip \
    && apt-get -y upgrade \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get -y install nodejs \
    && node --version \
    && apt-get -y update \
    && apt-get install -y curl unzip sudo \
    && curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok \
    && apt-get install -y openssh-server \
    && echo root:any | chpasswd && mkdir -p /var/run/sshd && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && echo "LD_LIBRARY_PATH=/usr/lib64-nvidia" >> /root/.bashrc && echo "export LD_LIBRARY_PATH" >> /root/.bashrc \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && ngrok authtoken 22DYIRNLb2fTdoumv0RukR6WyGS_7QonYvAYEnbescSM9MszU \
    && service ssh restart \
    && sudo useradd -g sudo user \
    && echo user:any | chpasswd
    
RUN rm -rf rclone
RUN git clone https://github.com/rishabh-modi2/rclone
WORKDIR /rclone
RUN npm install
RUN mkdir -p /app
ADD start.sh /app/
RUN mkdir -p /root/.ngrok2
ADD ngrok.yml /root/.ngrok2/


CMD bash /app/start.sh
