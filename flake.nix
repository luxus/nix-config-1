{
  description = "luxus's NixOS config";
  nixConfig.substituters = [
    "https://cache.nixos.org"
    "https://luxus.cachix.org"
    # "https://cache.ngi0.nixos.org"
    "https://nix-community.cachix.org"
    "https://pre-commit-hooks.cachix.org"
  ];
  nixConfig.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "luxus.cachix.org-1:eW/nJy5bZow2D3wf59qy7a9mfiZNjshIK/BozwgIlLU="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
  ];

  inputs = {
    nixgl = {
      url = "github:guibou/nixgl";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixpkgs.url = "nixpkgs/nixos-unstable";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
};
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
        flake-compat.follows = "flake-compat";
      };
    };

    utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.flake-utils.follows = "utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "nixos-hardware";
    nur.url = "nur";

    templates.url = "github:NixOS/templates";
  };

  outputs = { self, nixpkgs, utils, ... }@inputs:
    {
      deploy = import ./nix/deploy.nix inputs;

      overlays = {
        default = import ./nix/overlay.nix inputs;
        lite = import ./nix/mask-large-drvs.nix;
      };

      homeConfigurations = import ./nix/home-manager.nix inputs;

      nixosConfigurations = import ./nix/nixos.nix inputs;
    }
    // utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ] (system: {
      checks = import ./nix/checks.nix inputs system;

      devShells.default = import ./nix/dev-shell.nix inputs system;

      packages = {
        default = self.packages.${system}.all-hosts;
      } // (import ./nix/host-drvs.nix inputs system);

      nixpkgs = import nixpkgs {
        inherit system;
        overlays = [
          self.overlays.default
          # self.overlays.lite
        ];
        config.allowUnfree = true;
        config.allowAliases = true;
      };
    });
}
