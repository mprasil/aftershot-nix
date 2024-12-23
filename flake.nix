{
  description = "Flake package for Aftershot";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    utils,
    nixpkgs,
    ...
  }: (utils.lib.eachDefaultSystem (
    system: let
      pkgs = import nixpkgs {
        inherit system;

        config = {
          permittedInsecurePackages = [
            "qtwebkit-5.212.0-alpha4"
          ];
        };
      };
      packages.default = packages.aftershot;
      packages.aftershot = pkgs.callPackage ./aftershot.nix {};
      apps.default = apps.aftershot;
      apps.aftershot = {
        type = "app";
        program = "${packages.aftershot}/bin/AfterShot";
      };
    in {
      inherit apps packages;
    }
  ));
}
