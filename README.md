[![Build Status](https://travis-ci.org/mattsch/fedora-nzbget.svg?branch=master)](https://travis-ci.org/mattsch/fedora-nzbget)
# Fedora NZBGet Docker Container

Docker container for [NZBGet](http://nzbget.net/) using Fedora.

## Usage

Create with defaults:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -p 6789:6789 --name=nzbget mattsch/fedora-nzbget
```

Create with a custom uid/gid for the nzbget daemon:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -v /etc/localtime:/etc/localtime:ro \
    -e LUID=1234 -e LGID=1234 \
    -p 6789:6789 --name=nzbget mattsch/fedora-nzbget
```

## Tags

Tags should follow upstream releases (including prereleases) and latest should
be the latest built.

