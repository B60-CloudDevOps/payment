FROM python:3.13-alpine
# Install build dependencies
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev \
    linux-headers
RUN adduser -D -h /app roboshop
WORKDIR /app
COPY payment.ini payment.py rabbitmq.py requirements.txt ./
RUN pip3 install --no-cache-dir --user -r requirements.txt
CMD sleep 1000
# ENTRYPOINT ["/app/.local/bin/uwsgi", "--ini", "payment.ini"]
# EXPOSE 8080