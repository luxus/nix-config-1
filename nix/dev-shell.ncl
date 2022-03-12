{
  inputs_spec = {
    cachix = { input = "nixpkgs" },
    deploy-rs = { input = "deploy-rs" },
    jq = { input = "nixpkgs" },
    nix-build-uncached = { input = "nixpkgs" },
    nix-linter = { input = "nixpkgs" },
    nixpkgs-fmt = { input = "nixpkgs" },
    pre-commit = { input = "nixpkgs" },
    rnix-lsp = { input = "nixpkgs" },
    sops = { input = "nixpkgs" },
  }

  , output = fun { inputs, nix, .. } =>
    {
       name = "hello"

       , packages = [
         inputs.cachix,
         inputs.deploy-rs,
         inputs.jq,
         inputs.nix-build-uncached,
         inputs.nix-linter,
         inputs.nixpkgs-fmt,
         inputs.pre-commit,
         inputs.rnix-lsp,
         inputs.sops,
       ]

} | nix.Shell
}