# Fedora NZBGet Docker Container

Docker container for [NZBGet](http://nzbget.net/) using Fedora 22.

## Usage

Create with defaults:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -p 6789:6789 --name=nzbget mattsch/fedora-nzbget
```

Create with a custom uid/gid for the nzbget daemon:

```bash
docker create -v /path/to/config/dir:/config \
    -v /path/to/storage/dir:/storage \
    -e LUID=1234 -e LGID=1234 \
    -p 6789:6789 --name=nzbget mattsch/fedora-nzbget
```

Using host networking rather than the port forwards above will give the best
performance.  However, this allows the container to have full access to the
host's networking stack.  Be sure you understand the implications before using
it.

