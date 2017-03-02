# Using official python runtime base image
FROM python:2.7-alpine

# Set the application directory
WORKDIR /app

# Install our requirements.txt

ENV http_proxy http://proxyw.example.com:8080
ENV https_proxy https://proxyw.example.com:8080

ADD requirements.txt /app/requirements.txt
RUN pip install --proxy http://proxyw.example.com:8080 -r requirements.txt
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories
RUN apk update && apk add --update --no-cache curl


# Copy our code from the current folder to /app inside the container
ADD . /app

# Make port 80 available for links and/or publish
EXPOSE 80

# Define our command to be run when launching the container
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
