{ config, impermanence, lib, pkgs, ... }:
with lib;
{
  users.users.luxus = {
    createHome = true;
    extraGroups = [ "wheel" "dialout" ]
      ++ optionals config.hardware.i2c.enable [ "i2c" ]
      ++ optionals config.networking.networkmanager.enable [ "networkmanager" ]
      ++ optionals config.programs.sway.enable [ "input" "video" ]
      ++ optionals config.services.unbound.enable [ "unbound" ]
      ++ optionals config.sound.enable [ "audio" ]
      ++ optionals config.virtualisation.docker.enable [ "docker" ]
      ++ optionals config.virtualisation.libvirtd.enable [ "libvirtd" ]
      ++ optionals config.virtualisation.kvmgt.enable [ "kvm" ]
      ++ optionals config.virtualisation.podman.enable [ "podman" ]
      ++ optionals config.programs.wireshark.enable [ "wireshark" ]
      ++ optionals config.services.flatpak.enable [ "flatpak" ]
      ++ optionals config.services.ipfs.enable [ "ipfs" ];
    isNormalUser = true;
    shell = mkIf config.programs.zsh.enable pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 "AAAAC3NzaC1lZDI1NTE5AAAAID/AjBtg8D4lMoBkp2L3dDb5EmkOGr1v/Ns1wwRoKds4 luxuspur@gmail.com"
    ];
  };

  home-manager.users.luxus = {
    imports = [
      impermanence.home-manager.impermanence
      ./core
      ./dev
    ] ++ optionals config.programs.sway.enable [
      ./graphical
      ./graphical/sway
    ] ++ optionals config.services.xserver.desktopManager.gnome.enable [
      ./graphical
      ./graphical/gnome.nix
    ];
  };
}
