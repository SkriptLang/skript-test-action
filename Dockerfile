FROM python:3.12-alpine3.18
LABEL authors="SkriptLang"

ENV PYTHONUNBUFFERED=1

RUN apk add bash curl git zip
RUN curl -s "https://get.sdkman.io" | bash
RUN source "$HOME/.sdkman/bin/sdkman-init.sh"
# Install JDK 21 and set it as default
RUN yes | sdk install java 21.0.3-tem
# Install JDK 17 but don't set it as default
RUN yes n | sdk install java 17.0.11-tem
RUN apk add --no-cache git openjdk17
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community openjdk21
COPY run-tests.py /run-tests.py

ENTRYPOINT ["python3", "/run-tests.py"]
