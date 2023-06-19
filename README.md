svpb-signage
============

This is the documentation of the digital signage solution deployed in our sailing club (Segler-Verein Paderborn e.V., SVPB).

Hardware
--------
* Samsung "The Frame" 2023 32" (GQ32LS03CBUXZG)
    * Only 2,5 cm thick, thus nice appearence when mounted directly to the wall
    * Mounted vertically (it is very important to define the input source as "PC", else displaying content in portait mode is not possible, as the display automatically rotates the content to always be in landscape mode. Hacks like [removing the acceloremeter sensor](https://community.info-beamer.com/t/warning-do-not-purchase-the-frame-by-samsung-for-vertical-playback/1114) are not necessary for the 2023 model.)
    * "Art Mode" allows to use it as digital photo frame with motion detection while turned "off"
    * Via HDMI-CEC the display can be woken from and send back to "Art Mode"
* Lenovo M700 Tiny
    * Tiny form factor computer with i3-6100T, 8 GB RAM
    * Refurbished about the same cost as a Raspberry Pi 4 with accessories, but a bit more powerful
* Pulse-Eight USB-CEC Adapter
    * To automatically turn the display on and off via HDMI-CEC when the computer is running.
    * Allows the display to be turned on just when the actual content is ready (hides BIOS and boot messages).


Software
--------
The computer runs Debian with Openbox.
