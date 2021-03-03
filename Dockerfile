FROM alpine:latest
COPY . /app
WORKDIR /app
RUN apk update
RUN apk add bash jq exiftool ffmpeg mediainfo
RUN apk add --no-cache --upgrade grep
ENV PATH "$PATH:/app"
CMD ["/bin/bash"]
