FROM node:26.13.1-alpine3.23@sha256:39d8c143e60e99ae98f014bebea1e72fc96d3c9bdf9504bc3a27af5c05bfa39f AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev --no-audit --no-fund

RUN mkdir -p -m 700 /var/lib/vpa

FROM gcr.io/distroless/nodejs26-debian13:nonroot@sha256:a84242e747fbb5aaaa0180c273b6f7130ca34b3300082192ef58eea96089eb3c

WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder --chown=65532:65532 /var/lib/vpa /var/lib/vpa
COPY --from=builder /app/node_modules ./node_modules
COPY server.mjs .
COPY healthcheck.mjs .
COPY public ./public
COPY views ./views

EXPOSE 3000

USER nonroot

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s CMD ["/nodejs/bin/node", "/app/healthcheck.mjs"]

CMD ["server.mjs"]
