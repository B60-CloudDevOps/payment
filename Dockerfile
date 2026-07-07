FROM            python:3.13-alpine
RUN             adduser -D -h /app roboshop
WORKDIR         /app
USER            roboshop
COPY            payment.ini payment.py rabbitmq.py requirements.txt ./
# Ensure npm install is exectued to generate the node_modules directory and install all dependencies. This will be executed as a non-root user. But using security context at pod level, we will enforce to run it as non-root user
RUN             pip3.13 install --no-cache-dir --user -r requirements.txt
ENTRYPOINT      ["uwsgi", "--ini", "payment.ini"]
EXPOSE          8080
# This is how we can run container using roboshop account at container level;,But its perferred to deal at POD using PodSecurityContext