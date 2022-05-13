{ config, pkgs, ... }:
let
  dummyConfig = pkgs.writeText "configuration.nix" ''
    assert builtins.trace "This is a dummy config, use deploy-rs!" false;
    { }
  '';
in
{
  imports = [
    ./aspell.nix
    ./nix.nix
    ./fish.nix
    ./neovim.nix
    ./openssh.nix
    #./resolved.nix
    ./tmux.nix
    ./xdg.nix
    #./yggdrasil.nix
    #./zsh.nix
    #./solo2.nix
    #./dendrite-demo-pinecone.nix
  ];

  boot.kernelParams = [ "log_buf_len=10M" ];

  environment = {
    etc."nixos/configuration.nix".source = dummyConfig;
    systemPackages = with pkgs; [
    #  ntfs3g
      foot.terminfo
      btop
            curl
      libvterm-neovim
      neovim
      libtool automake autoconf
      nixpkgs-fmt
      vim
      wget
      ssh-copy-id
      aria2
      ssh-import-id
      fail2ban
      sshguard
      vim
      zathura
      lazygit
      nixfmt
      ncdu
      luaPackages.luacheck
      nvd
      exa
      ripgrep
      sqlite
      fzf
      fd
      prettyping
      asdf
      nodejs-17_x
      cargo
      nerd-font-patcher
      unzip
      #    spotifyd
      hyperfine
      zoxide
      bottom
      mcfly
      bandwhich
      gitui
      wget
      #  pcre2
      curl
      black
      luarocks
      shellcheck
      selene
      statix
      vim-vint
      mosh
      hadolint
      vale
      foot
        pavucontrol
      ncspot
      kmon
      nix-index
      pciutils
      uutils-coreutils
      stylua
      shfmt
      gotools
      ruby
      (python3.withPackages (ps: [ ps.setuptools ps.pyls-isort ]))
      chafa
      tangram
      parted
      cantata
#      minikube
 #     docker-machine-kvm2

    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    verbose = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
  LC_TIME = "de_DE.UTF-8";

};


  #networking = {
   # firewall = {
    #  trustedInterfaces = [ "tailscale0" ];
    #  allowedUDPPorts = [ config.services.tailscale.port ];
    #};
    #useDHCP = false;
    #useNetworkd = true;
    #wireguard.enable = true;
  #};

  nix.nixPath = [
    "nixos-config=${dummyConfig}"
    "nixpkgs=/run/current-system/nixpkgs"
    "nixpkgs-overlays=/run/current-system/overlays"
  ];

  nixpkgs.config.allowUnfree = true;

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  #services.tailscale.enable = true;
  #systemd.services.tailscaled.after = [ "network-online.target"  ];

  system = {
    extraSystemBuilderCmds = ''
      ln -sv ${pkgs.path} $out/nixpkgs
      ln -sv ${../nix/overlays} $out/overlays
    '';

    stateVersion = "22.05";
  };

  systemd.enableUnifiedCgroupHierarchy = true;

  time.timeZone = "Europe/Paris";

#  services.flatpak.enable = true;

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    meslo-lgs-nf
  ];


  users.mutableUsers = true;
}
