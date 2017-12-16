FROM node:alpine

ENV TERM xterm
ENV SERVER_PORT 3000
ENV PAYLOAD_MAX_SIZE 1048576000
ENV REPO_URL https://github.com/zrrrzzt/tfk-api-unoconv.git
ENV UNO_URL https://raw.githubusercontent.com/dagwieers/unoconv/master/unoconv

RUN apk add --no-cache \
        git \
        curl \
        libreoffice-common \
        libreoffice-writer \
        ttf-droid-nonlatin \
        ttf-droid \
        ttf-dejavu \
        ttf-freefont \
        ttf-liberation \
    && git clone --depth 1 $REPO_URL /unoconvservice \
    && rm -rf /unoconvservice/.git \
    && curl -Ls $UNO_URL -o /usr/local/bin/unoconv \
    && chmod +x /usr/local/bin/unoconv \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && cd /unoconvservice \
    && mkdir -p uploads \
    && yarn --production \
    && apk del git curl \
    && rm -rf /var/cache/apk/*

# Fonts:
ADD ./bookman-old-style /usr/share/fonts/bookman-old-style
ADD ./wingdings /usr/share/fonts/wingdings

WORKDIR /unoconvservice

EXPOSE 3000

ENTRYPOINT  /usr/local/bin/node /unoconvservice/standalone.js && /usr/local/bin/unoconv --listener --server=0.0.0.0 --port=2002