{ deploy-rs
, nixgl
, nixpkgs
, ragenix
, nur
, ...
}:

let
  inherit (nixpkgs.lib) composeManyExtensions;
  inherit (builtins) attrNames readDir;
  localOverlays = map
    (f: import (./overlays + "/${f}"))
    (attrNames (readDir ./overlays));

in
composeManyExtensions (localOverlays ++ [
  deploy-rs.overlay
  nixgl.overlay
  ragenix.overlay
  nur.overlay

])
