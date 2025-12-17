FROM alpine:3.19

# Install vsftpd and tini
RUN apk add --no-cache vsftpd tini

# Create anonymous user home directory
RUN mkdir -p /home/anonymous && \
    chown -R ftp:ftp /home/anonymous && \
    chmod 555 /home/anonymous

# Copy vsftpd configuration
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

# Expose FTP port
EXPOSE 21

# Use tini as init to properly handle signals
ENTRYPOINT ["/sbin/tini", "--"]

# Run vsftpd in the foreground
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
