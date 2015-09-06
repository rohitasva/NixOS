== NixOS on Macbook Pro

This repo has steps that I had to take to install nixos-15.09 on a separtate partition on macbook pro.

== Prerequisites
* Decrease the partition size of the OSX using disk utility and format the extra space as free for NixOS to be installed
* Download the iso from https://nixos.org/releases/nixos/15.09/nixos-15.09.189.a30ecea. We are going to use the minimal image.

== Prepare Installation Media (USB stick)
* Execute the command from the terminal: sudo dd bs=1m if=<location of the iso> of=/dev/diskX (where the USB is mounted, it can be found using diskutil list). This step might take some time.

