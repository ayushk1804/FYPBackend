#!/bin/bash
echo "starting copy..."
rm -rf /data-copy/* && cp -rf /data/ /data-copy/ && echo "copy finished!" && \
        rclone sync /data-copy/ fypbackend:/data/ && echo "Sync Successful" || echo "Sync didn't work"
