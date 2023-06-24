#!/bin/bash

exec 1>/opt/svpb-signage/openbox-presentation-run.log 2>&1

show_default () {
    cvlc --no-video-title-show --no-loop --play-and-exit --fullscreen /opt/svpb-signage/default_image.png
}

# Hide mouse
unclutter -display 0:0 -noevents -grab

# Keep screen on
xset -dpms     # Disable DPMS (Energy Star) features
xset s off     # Disable screensaver
xset s noblank # Don't blank video device


VIDEO_FILE="/opt/svpb-signage/content/video.mp4"

if [ -f $VIDEO_FILE ]
then
    echo "Start playing $VIDEO_FILE"
    cvlc --no-video-title-show --fullscreen --loop $VIDEO_FILE
else
    echo "File $VIDEO_FILE not found, show default image"
    show_default
fi

exit 0
