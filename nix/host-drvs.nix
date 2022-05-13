{ self, deploy-rs, nixpkgs, ... }:

system:

let
  inherit (self.nixpkgs.${system}) lib linkFarm;

  pkgs_arch64 = import nixpkgs {
    system = "aarch64-linux";
    inherit (self.nixpkgs."aarch64-linux") overlays config;
  };



  nixosDrvs = lib.mapAttrs (_: nixos: nixos.config.system.build.toplevel) self.nixosConfigurations;
  homeDrvs = lib.mapAttrs (_: home: home.activationPackage) self.homeConfigurations;
  hostDrvs = nixosDrvs // homeDrvs;
in
hostDrvs // {
  all-hosts = linkFarm "all-hosts" (lib.mapAttrsToList (name: path: { inherit name path; }) hostDrvs);
}
