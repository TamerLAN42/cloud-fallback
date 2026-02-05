FROM alpine:3.23
RUN apk add openssh-server openssh-client curl rsync

COPY sshd_config /etc/ssh/sshd_config
RUN chown root:root /etc/ssh/sshd_config && chmod 600 /etc/ssh/sshd_config

RUN ssh-keygen -A
# Пользователь-болванка для ssh-доступа
RUN adduser -D tunnel && \
    mkdir -p /home/tunnel/.ssh && \
    chown -R tunnel:tunnel /home/tunnel/.ssh && \
    chmod 700 /home/tunnel/.ssh && \
    passwd -u tunnel

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN sed -i 's/\r$//' /docker-entrypoint.sh # Фиксим кривое форматирование если скрипт трогался в виндоус
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]