FROM            docker.io/redhat/ubi9:9.8-1781496985
RUN             dnf install python3 gcc python3-devel -y && \
                dnf clean all
RUN             useradd -u 1000 roboshop 
RUN             mkdir /app && chown -R roboshop:roboshop /app
WORKDIR         /app
USER            roboshop
RUN             ./ /app/
# Ensure npm install is exectued to generate the node_modules directory and install all dependencies. This will be executed as a non-root user. But using security context at pod level, we will enforce to run it as non-root user
ADD             pip3 install -r requirements.txt
ENTRYPOINT      ["uwsgi", "--ini", "payment.ini"]
EXPOSE          8080
# This is how we can run container using roboshop account at container level;,But its perferred to deal at POD using PodSecurityContext
