FROM debian:stable-slim

ARG USER_ID=1000
ARG GROUP_ID=1000

LABEL org.opencontainers.image.authors="Michael Sasser <Info@MichaelSasser.org>" \
  org.opencontainers.image.description="vsftpd with support for FTPS, virtual users and passive mode." \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.version="3.0.3"


RUN apt-get update \
  && apt-get install -y --no-install-recommends vsftpd db-util iproute2\
  && apt-get clean

RUN usermod -u ${USER_ID} ftp \
  && groupmod -g ${GROUP_ID} ftp

ENV FTP_USER **String**
ENV FTP_PASS **Random**
ENV PASV_ADDRESS **IPv4**
ENV PASV_ADDR_RESOLVE NO
ENV PASV_ENABLE YES
ENV PASV_MIN_PORT 21100
ENV PASV_MAX_PORT 21110
ENV XFERLOG_STD_FORMAT NO
ENV LOG_STDOUT **Boolean**
ENV FILE_OPEN_MODE 0666
ENV LOCAL_UMASK 077
ENV REVERSE_LOOKUP_ENABLE YES
ENV PASV_PROMISCUOUS NO
ENV PORT_PROMISCUOUS NO
ENV SSL_ENABLE NO
ENV TLS_CERT cert.pem
ENV TLS_KEY key.pem


COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/

RUN chmod +x /usr/sbin/run-vsftpd.sh \
  && mkdir -p /home/vsftpd/ \
  && mkdir -p /var/log/vsftpd \
  && mkdir -p /etc/vsftpd/cert \
  && chown -R ftp:ftp /home/vsftpd/ \
  && chown -R ftp:ftp /var/log/vsftpd \
  && chown -R ftp:ftp /etc/vsftpd/cert

VOLUME /home/vsftpd
VOLUME /var/log/vsftpd
VOLUME /etc/vsftpd/cert

EXPOSE 20 21

CMD ["/usr/sbin/run-vsftpd.sh"]
