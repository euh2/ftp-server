# FTP Server Container

A lightweight anonymous FTP server running in Docker using Alpine Linux and vsftpd.

## Overview

This project provides a minimal, read-only FTP server that serves files from `/home/anonymous` directory. The container image is automatically built and pushed to GitHub Container Registry (GHCR).

## Features

- **Lightweight**: Built on Alpine Linux (~50MB)
- **Anonymous Access**: Allows anonymous users to download files
- **Read-Only**: Anonymous users cannot upload or modify files
- **Automated Builds**: GitHub Actions CI/CD pipeline builds and pushes to GHCR

## Quick Start

### Build Locally

```bash
docker build -t ftp-server .
```

### Run Container

```bash
docker run -d \
  --name ftp-server \
  -p 21:21 \
  -p 21100-21110:21100-21110 \
  -v /path/to/files:/home/anonymous:ro \
  ftp-server
```

Replace `/path/to/files` with the directory containing files to serve.

### Connect via FTP

```bash
ftp localhost
# Login with username: anonymous
# Password: (any email address)
```

## Configuration

The FTP server is configured via `vsftpd.conf`:

- **Anonymous Login**: Enabled
- **Local User Login**: Disabled
- **Uploads**: Disabled (read-only)
- **PASV Mode**: Enabled with ports 21100-21110
- **Root Directory**: `/home/anonymous`

## Docker Compose Example

```yaml
version: '3.8'
services:
  ftp:
    image: ghcr.io/your-username/ftp-server-container:latest
    ports:
      - "21:21"
      - "21100-21110:21100-21110"
    volumes:
      - ./ftp-files:/home/anonymous:ro
```

## GitHub Actions Workflow

The `.github/workflows/build.yml` workflow:

1. Triggers on pushes to `main` and pull requests
2. Builds the Docker image using Docker Buildx
3. Pushes to GHCR (main branch only)
4. Automatically tags with branch name, git SHA, and `latest` tag

### Setup

To use the GitHub Actions workflow, ensure:

1. Your repository is on GitHub
2. GitHub Actions are enabled
3. The repository has permission to push to GHCR (GitHub > Settings > Actions > General > Workflow Permissions)

## Security Notes

- This is an anonymous-only FTP server suitable for public file distribution
- The `/home/anonymous` directory must be mounted as read-only for security
- No local users can authenticate
- All connections are logged to stdout via xferlog

## Image Size

- Base Alpine: ~7MB
- vsftpd package: ~200KB
- **Total: ~10-15MB compressed**

## License

MIT
