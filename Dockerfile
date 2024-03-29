FROM python:3.12-alpine3.18
LABEL authors="SkriptLang"

ENV PYTHONUNBUFFERED=1

RUN apk add --no-cache git openjdk17
COPY run-tests.py /run-tests.py

ENTRYPOINT ["python3", "/run-tests.py"]
