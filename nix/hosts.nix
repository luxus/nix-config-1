let
  inherit (builtins) attrNames concatMap listToAttrs;

  filterAttrs = pred: set:
    listToAttrs (concatMap (name: let value = set.${name}; in if pred name value then [{ inherit name value; }] else [ ]) (attrNames set));

  hosts = {
    vanessa = {
      type = "nixos";
      localSystem = "x86_64-linux";
      address = "vanessa";
    };
    emily = {
      type = "nixos";
      localSystem = "x86_64-linux";
      address = "emily";
    };
    work = {
      type = "nixos";
      localSystem = "x86_64-linux";
      address = "work";
    };
  };
in
{
  all = hosts;

  nixos = rec {
    all = filterAttrs (_: v: v.type == "nixos") hosts;
    x86_64-linux = filterAttrs (_: v: v.localSystem == "x86_64-linux") all;
    aarch64-linux = filterAttrs (_: v: v.localSystem == "aarch64-linux") all;
  };

  homeManager = rec {
    all = filterAttrs (_: v: v.type == "home-manager") hosts;
    x86_64-linux = filterAttrs (_: v: v.localSystem == "x86_64-linux") all;
    aarch64-linux = filterAttrs (_: v: v.localSystem == "aarch64-linux") all;
  };
}
