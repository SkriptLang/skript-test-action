FROM python:3.12-alpine3.18
LABEL authors="SkriptLang"

RUN apk add --no-cache git openjdk17
COPY run-tests.py /run-tests.py

CMD ["/bin/sh", "-c", "python", "/run-tests.py"]