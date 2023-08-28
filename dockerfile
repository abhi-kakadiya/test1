FROM python:3.8-alpine3.10
LABEL maintainer="Abhi Kakadiya"

WORKDIR /app

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt 
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
RUN python -m venv /py && \
    /py/bin/pip install -r requirements.txt && \
    if [ $DEV == 'true' ]; \
    then /py/bin/pip install -r requirements.dev.txt && \
    fi && \
    rm -rf /tmp && \
    add-user \
    --disabled-password \
    --no-create-home \
    tmp-user

ENV path="/py/bin:${PATH}"

USER tmp-user

