FROM python:3.8-alpine3.10
LABEL maintainer="Abhi Kakadiya"

WORKDIR /app

ENV PYTHONUNBUFFERED 1

# Install build dependencies
RUN apk add --no-cache build-base libffi-dev openssl-dev

COPY ./requirements.txt /tmp/requirements.txt 
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = 'true' ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    tmp-user

ENV PATH="/py/bin:$PATH"

USER tmp-user

