## NixOS on Macbook Pro

This repo has steps that I had to take to install nixos-15.09 on a separtate partition on macbook pro.

## Prerequisites
1. Hard wired ethernet connection. This is required for the first nixos-install. After that we can set up wireless connection.
2. Resize OSX partition to allocate enough space for NixOS using disk utility. Format the extra space as free for NixOS to be installed
3. Download the iso from https://nixos.org/releases/nixos/15.09/nixos-15.09.189.a30ecea. We are going to use the minimal image.

## Prepare Installation Media (USB stick)
1. Execute the command 
  ```
  sudo dd bs=1m if=<location of the iso> of=/dev/diskX 
  ```
  from the terminal. DiskX is the location where the USB is mounted (it can be found using command 
  ```
  diskutil list
  ```
  ) This step might take some time to complete. 


## Booting using the USB and creating new partitions for NixOS
1. Hold down alt key while booting and select the USB to boot from. If all is good, you should be able to login as root. (Note: There is no password for root)
2. Use fdisk to create partitions for NixOS. For me I created /dev/sda4 (nixos home) and /dev/sda5 (nixos swap)
3. Once the partitions are created use the following commands:
```
  $ mkfs.ext4 -L nixosroot /dev/sda4
  $ mkswap -L nixosswap /dev/sda5
  $ mkfs.vfat /dev/sda1
  $ mount /dev/sda4 /mnt
  $ mkdir /mnt/boot
  $ mount /dev/sda1 /mnt/boot 
```

## Create nix configuration file and install the operating system.
  ```
  $ nixos-generate-config --root /mnt
  ``` 
  Update the /mnt/etc/nixos/configuration.nix to include
  ```
    nixpkgs.config.allowUnfree = true;
    networking.wireless.enable = true;
    
    environment.systemPackages = with pkgs; [
      git
    ];
  ```
  Then run ```$ nixos-install```to install the operating system. You can exclude installing git. I did it to get 
  my configuration for later.
  Once the installation is complete, you should be able to reboot into NixOS directly

## Getting wireless to work 
  Update the /etc/wpa_supplicant.conf as follows and restart wpa_supplicant.service. You should have intenet connectivity after this.
```
network={
  ssid="<Network ID>"
  psk="password"
}
```
  
