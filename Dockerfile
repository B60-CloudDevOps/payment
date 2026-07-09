FROM docker.io/library/python:3.13-alpine
WORKDIR /app
COPY payment.ini payment.py rabbitmq.py requirements.txt ./
RUN apk add --no-cache gcc musl-dev linux-headers

RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir uwsgi

ENTRYPOINT ["uwsgi", "--ini", "payment.ini"]