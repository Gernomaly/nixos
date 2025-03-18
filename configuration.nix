 { pkgs, ... }:
 
 {
   nix.settings = {
     experimental-features = "nix-command flakes";
     auto-optimise-store = true;
   };
   
   environment.systemPackages = [
     pkgs.vim
     pkgs.git
     pkgs.zip
     pkgs.unzip
     pkgs.wget
   ];
   
   fileSystems."/" = {
     device = "/dev/disk/by-label/nixos";
     fsType = "ext4";
   };
   fileSystems."/boot" = {
     device = "/dev/disk/by-label/boot";
     fsType = "ext4";
   };
   swapDevices = [
     {
       device = "/dev/disk/by-label/swap";
     }
   ];
   
   documentation.nixos.enable = false;
   time.timeZone = "Europe/Amsterdam";
   i18n.defaultLocale = "en_GB.UTF-8";
   console.keyMap = "de";
   nix.settings.trusted-users = [ "@wheel" ];
   
   boot.loader.grub.enable = true;
   boot.loader.grub.device = "/dev/sda";
   boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "ext4" ];
   
   users.users = {
     root.hashedPassword = "!"; # Disable root login
     Xeni = {
       isNormalUser = true;
       extraGroups = [ "wheel" ];
       openssh.authorizedKeys.keys = [
        sk-ssh-ed25519 AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIEMXzEETnle9DcGw8Zow0Lw7GizL/f3t5W3x6+kWTQl1AAAABHNzaDo= Xeni
       ];
     };
   };
   
   security.sudo.wheelNeedsPassword = false;
   
   services.openssh = {
     enable = true;
     settings = {
       PermitRootLogin = "no";
       PasswordAuthentication = false;
       KbdInteractiveAuthentication = false;
     };
   };
      
   # This value determines the NixOS release from which the default
   # settings for stateful data, like file locations and database versions
   # on your system were taken. It‘s perfectly fine and recommended to leave
   # this value at the release version of the first install of this system.
   # Before changing this value read the documentation for this option
   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "24.11"; # Did you read the comment?
 }
