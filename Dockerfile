FROM rishabhmodi2003/codetest:1
# Install sshd
EXPOSE 4040
CMD bash /app/codetest.sh
# CMD wget https://gitlab.com/rishabh-modi2/public/-/raw/main/codetest.sh && chmod 777 codetest.sh && ./codetest.sh
