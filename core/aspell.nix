{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.de_DE
    aspellDicts.de_CH
  ];

  # Configure aspell system wide
  environment.etc."aspell.conf".text = ''
    master en_US
    add-extra-dicts en-computers.rws
    add-extra-dicts de_DE.rws
    add-extra-dicts de_CH.rws
  '';
}
