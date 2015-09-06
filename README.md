## NixOS on Macbook Pro

This repo has steps that I had to take to install nixos-15.09 on a separtate partition on macbook pro.

## Prerequisites
1. Decrease the partition size of the OSX using disk utility and format the extra space as free for NixOS to be installed
2. Download the iso from https://nixos.org/releases/nixos/15.09/nixos-15.09.189.a30ecea. We are going to use the minimal image.

## Prepare Installation Media (USB stick)
1. Execute the command 
  ```shell
  sudo dd bs=1m if=<location of the iso> of=/dev/diskX 
  ```
  from the terminal. DiskX is the location where the USB is mounted (it can be found using command 
  ```shell
  diskutil list
  ```
  ) This step might take some time to complete. 


## Booting using the USB and creating new partitions for NixOS
1. Hold down <opti>

