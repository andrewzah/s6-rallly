FROM node:alpine as build

RUN apk add git

ARG RALLLY_VERSION
RUN git clone https://github.com/lukevella/rallly.git /app/rallly \
  && cd /app/rallly \
  && git checkout "$RALLLY_VERSION"

WORKDIR /app/rallly

RUN set -euxo pipefail \
  && yarn --frozen-lockfile \
  && yarn build

RUN rm -rf node_modules

FROM andrewzah/base-alpine:3.15

RUN apk add \
  nodejs \
  yarn

ENV PORT 3000
EXPOSE 3000

WORKDIR /usr/src/app

COPY --from=build /app .

COPY ./root/ /
