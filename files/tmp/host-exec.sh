#!/bin/bash

grep -v '^#' /tmp/commands | while read line ; do
    ln -s /usr/bin/distrobox-host-exec /usr/local/bin/$line
done
