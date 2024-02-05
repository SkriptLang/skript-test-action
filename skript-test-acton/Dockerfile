FROM alpine:3.19.1
LABEL authors="SkriptLang"

RUN apk add --no-cache git
COPY run-tests.sh /run-tests.sh

ENTRYPOINT ["/run-tests.sh"]