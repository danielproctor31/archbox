#!/bin/bash

host_spawn_version="1.4.1"

echo "Installing host-spawn"

if ! curl -L "https://github.com/1player/host-spawn/releases/download/${host_spawn_version}/host-spawn-$(uname -m)" -o /tmp/host-spawn; then
    echo "Error: Cannot download host-spawn"
fi
if [ -e /tmp/host-spawn ]; then
    mv /tmp/host-spawn /usr/bin/
    chmod +x /usr/bin/host-spawn
fi

grep -v '^#' /tmp/commands | while read line ; do
    echo "Adding $line to distrobox-host-exec"
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/$line
done
