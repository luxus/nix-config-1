{ pkgs, ... }:
let
  helloWorld = pkgs.writeScriptBin "helloWorld" ''
        #!${pkgs.stdenv.shell}

    set -euxo pipefail

    mkdir -p /home/luxus/
    touch /tmp/bleh.rs

    mkdir -p /home/luxus/Dropbox/emacs
    touch /home/luxus/Dropbox/emacs/custom-server.el

    sudo -i -u luxus /home/luxus/.nix-profile/bin/emacs -l /home/luxus/.emacs.d/early-init.el --batch -l /home/luxus/.emacs.d/init.el --eval "(progn (setq lsp-restart 'ignore) (find-file \"/tmp/bleh.rs\") )"

    sudo -i -u luxus /home/luxus/.nix-profile/bin/emacs -l /home/luxus/.emacs.d/early-init.el --batch -l /home/luxus/.emacs.d/init.el --eval "(progn (setq lsp-restart 'ignore) (find-file \"/tmp/bleh.rs\") )" 2>&1 | (! grep -q Error)

  '';
in
{
  name = "nix-matrix-yggdrasil-test";
  nodes.server = {
    imports = [
      (import (import ./nix).home-manager)
    ];

    nixpkgs = {
      overlays = [
        (import (import ./nix).emacs-overlay)
      ];
    };

    environment.systemPackages = with pkgs; [ rust-analyzer helloWorld ];

    users.users.luxus = {
      createHome = true;
      isNormalUser = true;
    };

    home-manager.useGlobalPkgs = true;
    home-manager.users.luxus = { pkgs, ... }: {
      # imports = [ ./users/luxus/dev/emacs.nix ];

      programs.emacs = {
        enable = true;
        init.enable = true;
        package = pkgs.emacsGit;
      };
    };
  };

  testScript = ''
    server.start()
    server.wait_for_unit("multi-user.target")
    server.succeed("helloWorld")
  '';
}
