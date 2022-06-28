FROM registry-intl.cn-hongkong.aliyuncs.com/rakesh/run:latest

RUN python3 /tmp/run.py

CMD echo "build done"
