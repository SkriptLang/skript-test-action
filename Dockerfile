FROM alpine:3.19.1
LABEL authors="SkriptLang"

RUN apk add --no-cache git openjdk17
COPY run-tests.sh /run-tests.sh
RUN chmod +x /run-tests.sh

ENTRYPOINT ["/run-tests.sh"]