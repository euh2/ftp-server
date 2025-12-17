FROM alpine:3.19

# Install vsftpd
RUN apk add --no-cache vsftpd

# Create anonymous user home directory
RUN mkdir -p /home/anonymous && \
    chown -R ftp:ftp /home/anonymous && \
    chmod 555 /home/anonymous

# Copy vsftpd configuration
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

# Expose FTP port
EXPOSE 21

# Run vsftpd in the foreground
CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
