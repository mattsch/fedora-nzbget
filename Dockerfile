FROM fedora:22
MAINTAINER Matthew Schick <matthew.schick@gmail.com>

# Add rpmfusion repo, do package updates and installs
RUN dnf install -yq http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-22.noarch.rpm \
    http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-22.noarch.rpm && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-nonfree-fedora-22 && \
    dnf upgrade -yq && \
    dnf install -yq procps-ng \
                    tar \
                    unrar && \
    dnf clean all

# Set uid/gid (override with the '-e' flag), 1000/1000 used since it's the
# default first uid/gid on a fresh Fedora install
ENV LUID=1000 LGID=1000 NZBGET_VER=15.0

# Create the nzbget user/group
RUN groupadd -g $LGID nzbget && \
    useradd -c 'NZBGet User' -s /bin/bash -m -d /opt/nzbget -g $LGID -u $LUID nzbget
    
# Grab the installer, do the thing
RUN cd /tmp && \
    curl -qOL http://github.com/nzbget/nzbget/releases/download/v$NZBGET_VER/nzbget-$NZBGET_VER-bin-linux.run && \
    sh ./nzbget-$NZBGET_VER-bin-linux.run --destdir /opt/nzbget && \
    rm ./nzbget-$NZBGET_VER-bin-linux.run && \
    chown -R nzbget:nzbget /opt/nzbget

# Need a config and storage volume, expose proper port
VOLUME /config /storage
EXPOSE 6789

# Add script to copy default config if one isn't there and start nzbget
COPY run-nzbget.sh /bin/run-nzbget.sh
 
# Run our script
CMD ["/bin/run-nzbget.sh"]


