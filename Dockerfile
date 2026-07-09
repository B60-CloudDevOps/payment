FROM docker.io/library/python:3.12-slim
WORKDIR /app
COPY payment.ini payment.py rabbitmq.py requirements.txt ./
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev \
    linux-headers
# Install build dependencies
RUN pip install --no-cache-dir -r requirements.txt -t /app/

ENTRYPOINT ["/app/.local/bin/uwsgi", "--ini", "payment.ini"]
