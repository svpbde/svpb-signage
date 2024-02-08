svpb-signage
============

This is a simple digital signage solution deployed in our sailing club (Segler-Verein Paderborn e.V., SVPB).

Features
--------
* Display a single video in an infinite loop
* Display a website
* Alternate between website and video 

To keep the complexity low, the feature set is not enormous.
A single video file is chosen as interchange format.
* Video gets updated via owncloud/nextcloud (is already in use, no need to maintain additional software)
* Video can be created with creators favourite software (e.g. exported from PowerPoint presentations)
* Looking at video file at home gives good representation of later appearance on signage system

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

### Installation

* Prepare ansible configuration
    * In `ansible\vars`, copy `cloud_vars.yml.example` to `cloud_vars.yml`
    * Fill in the data of your nextcloud or owncloud hosting your signage video
* Install debian on the signage computer. Installer settings:
    * System name: `signage`
    * Create a normal user named `svpb` (this is not the signage user, which will be created lateron via ansible)
    * Deselect "Debian desktop environment" and "Gnome", select "SSH Server"
* Boot the freshly installed system. Login as root and configure sudo: `apt install sudo` & `usermod -aG sudo svpb`.
* From your own computer
    * Add SSH Key: `ssh-copy-id -i ~/.ssh/id_ed25519 svpb@signage`
    * Clone this repo & `cd ansible`
    * Run ansible: `ansible-playbook playbook.yml -i inventory.yml --ask-become-pass`
* Reboot

### Usage
The behaviour of the signage system is defined by systemd user services.
The user `svpb-signage` has to be used as he is the one who owns the running X session (auto login).

#### Controlling system over SSH
Manage systemd user services for `svpb-signage`:
```
sudo -u svpb-signage XDG_RUNTIME_DIR=/run/user/$(id -u svpb-signage) systemctl --user <your systemd command>
```
Manually play video on the screen without systemd (for debugging):
```
sudo -u svpb-signage DISPLAY=:0 mpv video.mp4
```

#### Infinite video loop
Enable and start the services `signage-cloud-sync.timer` and `signage-video-loop`.
Also enable `signage-video-loop-restart.path`.

#### Display website
Adapt, enable and start `signage-website`.

#### Display website and video
Adapt, enable and start `signage-website`.
The website stays in the background.
Enable and start `signage-cloud-sync.timer` and `signage-video.timer`.
This starts the video in the foreground regularly.

### Testing
The system can easily be tested on a virtual machine.
Using the Vagrantfile in this repo with Vagrant automatically spins up a working VM.
However, describing how to use Vagrant is out of the scope of this document.
