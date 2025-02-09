FROM alpine:latest AS build

RUN apk --no-cache add ca-certificates
RUN mkdir -p /tmp

# —————————————————————————————————————————————————————————————————————
FROM scratch
ARG DIST_DIR=./dist

# Needed for version check HTTPS request
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
# Needed for image content cache
COPY --from=build /tmp /

COPY ${DIST_DIR}/syft_linux_amd64/syft /

ENTRYPOINT ["/syft"]
