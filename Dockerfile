FROM python:3.12-alpine3.18
LABEL authors="SkriptLang"

ENV PYTHONUNBUFFERED=1

RUN apk add bash curl git zip
RUN curl -s "https://get.sdkman.io" | bash
RUN bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk version"
# Install JDK 21 and set it as default
RUN bash -c "yes | sdk install java 21.0.3-tem"
# Install JDK 17 but don't set it as default
RUN bash -c "yes n | sdk install java 17.0.11-tem"
COPY run-tests.py /run-tests.py

ENTRYPOINT ["python3", "/run-tests.py"]
