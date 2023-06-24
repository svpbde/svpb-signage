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


# Start chromium first - window will be overlayed by vlc
chromium --kiosk --app=https://svpb.de/ --noerrdialogs --enable-features=OverlayScrollbar --disable-restore-session-state &
# Give chromium some time to load - else vlc will start first
sleep 5

VIDEO_FILE="/opt/svpb-signage/content/video.mp4"

while :
do
    if [ -f $VIDEO_FILE ]
    then
        echo "Start playing $VIDEO_FILE"
        cvlc --no-video-title-show --no-loop --play-and-exit --fullscreen $VIDEO_FILE
        # Pause video playback to show chromium
        sleep 30
    else
        echo "File $VIDEO_FILE not found, show default image"
        show_default
    fi
done

exit 0
