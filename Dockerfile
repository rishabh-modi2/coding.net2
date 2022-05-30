FROM  ubuntu
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
# Install ngrok
ENV NOTVISIBLE "in users profile"
RUN apt update -y && apt install -y tar curl openssh-client openssh-server
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
    && /usr/sbin/sshd && ngrok config add-authtoken 1ttZhgDBXTNa3xaGrFkI15bhnUp_3ZgG54Byr2RPeV64L3TJy && ngrok tcp 22

ENTRYPOINT ["/app/start.sh"]
#RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.xtom.com.hk/g' /etc/apt/sources.list
#RUN apt update -y && apt install python3 -y
#ENV DEBIAN_FRONTEND=noninteractive
#RUN wget https://drive.google.com/uc?export=view&id=1YY9o8kw31eiDRArivzXhGSern31YtrNn
#RUN ls
#RUN du -sh *
