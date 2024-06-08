FROM python:3.12-alpine3.18
LABEL authors="SkriptLang"

ENV PYTHONUNBUFFERED=1

RUN apk add bash curl git zip
RUN curl -s "https://get.sdkman.io" | bash
RUN echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> ~/.profile
RUN bash -c "yes | sdk install java 21.0.3-tem && \
    yes n | sdk install java 17.0.11-tem && \
    rm -rf $HOME/.sdkman/archives/* && \
    rm -rf $HOME/.sdkman/tmp/*"
COPY run-tests.py /run-tests.py

ENTRYPOINT ["python3", "/run-tests.py"]
