{ pkgs, ... }:
let
  dconf2nix = (import (import ../../nix).dconf2nix);
in
{
  home = {
    # stateVersion = "20.03";
    packages = with pkgs; [
      peek
      gnomeExtensions.mpris-indicator-button
      gnomeExtensions.paperwm
      gnomeExtensions.dash-to-dock
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator
      # gnomeExtensions.gsconnect # kde connect
      gnome3.gnome-tweaks
      tilix
      dconf2nix
    ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs.latest.firefox-nightly-bin;
  };

  gtk = {
    enable = true;
    gtk2.extraConfig = "gtk-application-prefer-dark-theme = true";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  qt = {
    enable = false;
    platformTheme = "gnome";
  };

  services.gpg-agent.pinentryFlavor = "gnome3";
  services.flameshot.enable = true;
  services.rsibreak.enable = true;
  services.unclutter.enable = true;
  services.gnome-keyring.enable = true;
}
