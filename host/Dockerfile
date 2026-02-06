FROM alpine:3.23
RUN apk add  --no-cache rsync openssh-client
COPY sync.sh /sync.sh
RUN sed -i 's/\r$//' /sync.sh # Фиксим кривое форматирование если sync.sh трогался в виндоус
RUN chmod +x /sync.sh
ENTRYPOINT ["/bin/sh", "-c", "trap exit TERM; while :; do /bin/sh /sync.sh; sleep $SYNC_TIMEOUT; done"]